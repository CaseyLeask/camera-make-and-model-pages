require 'uri'
require 'net/http'
require 'oga'
require_relative 'index_page'
require_relative 'make_pages'
require_relative 'model_pages'

# Used to write the pages to the output directory
class Writer
  def self.write(pages, output_directory)
    # pages.each { |_k, page| puts page }
    pages.each { |filename, _page| puts File.expand_path(filename, output_directory) }
  end
end
