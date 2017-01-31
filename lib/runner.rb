require 'uri'
require 'net/http'
require 'oga'

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
    document = Oga.parse_xml(Net::HTTP.get(api_url))
    works = document.css('works work')

    put works
  end
end
