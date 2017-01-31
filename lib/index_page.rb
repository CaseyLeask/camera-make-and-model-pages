require 'erb'
require_relative 'template'

# All things required to generate the IndexPage
class IndexPage
  def initialize(works)
    @works = works
  end

  def generate(template)
    template_values = {
      title: 'works',
      thumbnails: thumbnails,
      navigation: navigation
    }

    { 'index' => Template.generate(template, template_values) }
  end

  def thumbnails
    @works.take(10).map do |work|
      {
        src: work.css('urls url[type="small"]').text,
        alt: work.css('filename').text
      }
    end
  end

  def navigation
    links = @works.map do |work|
      {
        href: '/' + ERB::Util.url_encode(work.css('make').text),
        text: work.css('make').text
      }
    end

    links.uniq.reject { |link| link[:text].empty? }
  end
end
