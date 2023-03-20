class Api::V1::UsersController < ApplicationController
  def index
    render json: {hi: "hello"}, status: :ok
  end
end
