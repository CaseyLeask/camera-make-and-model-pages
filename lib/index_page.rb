class IndexPage
  def initialize(works)
  end

  def generate
    File.read('lib/template.html')
  end
end
