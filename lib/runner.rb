require 'uri'

class Runner
  attr_accessor :api_url, :output_directory
  def initialize(argv)
    raise ArgumentError unless argv.length == 2
    @api_url = URI(argv[0])
    raise URI::InvalidURIError if @api_url.relative?

    Dir.mkdir(argv[1]) unless Dir.exist?(argv[1])
    @output_directory = Dir.new(argv[1])
  end
end
