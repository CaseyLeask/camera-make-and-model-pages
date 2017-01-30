class Runner
  attr_accessor :api_url, :output_directory
  def initialize(argv)
    raise ArgumentError unless argv.length == 2
  end
end
