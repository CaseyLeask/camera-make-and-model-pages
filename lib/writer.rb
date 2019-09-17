# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'oga'
require_relative 'index_page'
require_relative 'make_pages'
require_relative 'model_pages'

# Used to write the pages to the output directory
class Writer
  def self.write(pages, output_directory)
    pages.each do |filename, page|
      path = File.expand_path(filename, output_directory)
      File.write(path, page)
    end
  end
end
