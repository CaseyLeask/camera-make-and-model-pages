# frozen_string_literal: true

require_relative 'parser'
require_relative 'writer'

# Used to separate argument value passing from the application
class Runner
  attr_accessor :api_url, :output_directory
  def initialize(argv)
    raise ArgumentError unless argv.length == 2

    @api_url = URI.parse(argv[0])
    raise URI::InvalidURIError if @api_url.relative?

    Dir.mkdir(argv[1]) unless Dir.exist?(argv[1])
    @output_directory = Dir.new(argv[1])
  end

  def run!
    pages = Parser.parse(@api_url)

    Writer.write(pages, @output_directory)
  end
end
