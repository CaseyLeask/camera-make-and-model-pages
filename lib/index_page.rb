require 'erb'

class IndexPage
  def initialize(works)
  end

  def generate
    erb_binding = binding
    erb_binding.local_variable_set(:title, 'works')
    ERB.new(File.read('lib/template.html.erb')).result(erb_binding)
  end
end
