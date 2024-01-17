# frozen_string_literal: true

module Payments
  module PgHdfc
    module Crypto
      INIT_VECTOR = (0..15).to_a.pack('C*')

      def encrypt(plain_text, key)
        secret_key = [Digest::MD5.hexdigest(key)].pack('H*')
        cipher = OpenSSL::Cipher.new('aes-128-cbc')
        cipher.encrypt
        cipher.key = secret_key
        cipher.iv  = INIT_VECTOR
        encrypted_text = cipher.update(plain_text) + cipher.final
        encrypted_text.unpack1('H*')
      end

      def decrypt(cipher_text, key)
        secret_key = [Digest::MD5.hexdigest(key)].pack('H*')
        encrypted_text = [cipher_text].pack('H*')
        decipher = OpenSSL::Cipher.new('aes-128-cbc')
        decipher.decrypt
        decipher.key = secret_key
        decipher.iv  = INIT_VECTOR
        (decipher.update(encrypted_text) + decipher.final).gsub(/\0+$/, '')
      end
    end
  end
end
