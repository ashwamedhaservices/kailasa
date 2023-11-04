# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class RestRequestHandler
  Response = Struct.new(:code, :body)

  def initialize(base_url)
    @base_url = base_url
  end

  def get(path, headers = {})
    send_request(Net::HTTP::Get, path, headers)
  end

  def post(path, body = {}, headers = {})
    send_request(Net::HTTP::Post, path, headers, body)
  end

  def post_form(path, body = {})
    parse_response(Net::HTTP.post_form(URI.join(@base_url, path), body))
  end

  def put(path, body = {}, headers = {})
    send_request(Net::HTTP::Put, path, headers, body)
  end

  def delete(path, headers = {})
    send_request(Net::HTTP::Delete, path, headers)
  end

  private

  def send_request(request_class, path, headers = {}, body = nil)
    url = URI.join(@base_url, path)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = url.scheme == 'https'

    request = request_class.new(url)
    headers.each { |key, value| request[key] = value }
    request.body = body.to_json if body

    response = http.request(request)
    parse_response(response)
  end

  def parse_response(response)
    Response.new(code: response.code.to_i, body: response.body.empty? ? nil : JSON.parse(response.body))
  end
end
