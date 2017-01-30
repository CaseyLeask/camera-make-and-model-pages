require 'erb'

class IndexPage
  def initialize(works)
    @works = works
  end

  def generate
    erb_binding = binding
    erb_binding.local_variable_set(:title, 'works')
    erb_binding.local_variable_set(:thumbnails, thumbnails)
    ERB.new(File.read('lib/template.html.erb'), 0, '>').result(erb_binding)
  end

  def thumbnails
    @works.take(10).map do |work|
      {
        src: work.css('urls url[type="small"]').text,
        alt: work.css('filename').text
      }
    end
  end
end
