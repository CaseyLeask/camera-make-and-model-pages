# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'oga'

# ERB requires the use of a binding instead of a hash
class Template
  def self.generate(template, values)
    erb_binding = binding

    values.each do |key, value|
      erb_binding.local_variable_set(key, value)
    end

    ERB.new(template, 0, '>').result(erb_binding)
  end

  def self.sanitize_link(link)
    link.gsub(/\W/, '')
  end
end
