# -*- encoding: utf-8 -*-
require 'encrypted_strings'

module Mongoid #:nodoc:

  # mongoid-encryptor encrypts and decrypts one or more fields in a Mongoid model.
  module Encryptor
    extend ActiveSupport::Concern

    module ClassMethods #:nodoc:
      # @param [Hash] attrs
      def encrypts(*attrs)
        base_options = attrs.last.is_a?(Hash) ? attrs.pop : {}

        attrs.each do |attr_name|
          options = base_options.dup
          attr_name = attr_name.to_s

          mode = options.delete(:mode) || :sha
          cipher_class = EncryptedStrings.const_get("#{mode.to_s.classify}Cipher")

          send(:after_validation) do |doc|
            doc.send(:write_encrypted_attribute, attr_name, cipher_class, options)
            true
          end

          define_method(attr_name) do
            read_encrypted_attribute(attr_name, cipher_class, options)
          end
        end
      end
    end

    module InstanceMethods #:nodoc:
      # Returns decrypted value for key.
      #
      # @param [String] key
      # @return [Object]
      def read_attribute_for_validation(key)
        v = read_attribute(key)
        v.try(:encrypted?) ? v.decrypt : v
      end

      private

      # @param [String] attr_name
      # @param [Class] cipher_class
      # @param [Hash] options
      def write_encrypted_attribute(attr_name, cipher_class, options)
        value = read_attribute(attr_name.to_sym)
        return if value.blank? or value.encrypted?

        cipher = instantiate_cipher(cipher_class, options)
        value = cipher.encrypt(value)
        value.cipher = cipher
        send("#{attr_name}=", value)
      end

      # @param [String] attr_name
      # @param [Class] cipher_class
      # @param [Hash] options
      # @return [String]
      def read_encrypted_attribute(attr_name, cipher_class, options)
        value = read_attribute(attr_name)

        unless value.blank? || value.encrypted? || attribute_changed?(attr_name) || new_record?
          value.cipher = instantiate_cipher(cipher_class, options)
        end

        value
      end

      # @param [Class] cipher_class
      # @param [Hash] options
      # @return [EncryptedStrings::Cipher]
      def instantiate_cipher(cipher_class, options)
        cipher_class.new(options.dup)
      end
    end
  end

end
