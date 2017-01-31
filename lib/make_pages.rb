require 'erb'
require_relative 'template'

# All things required to generate the MakePages
class MakePages
  def initialize(works)
    @works = works
  end

  def generate(template)
    makes.reduce({}) do |collection, make|
      template_values = {
        title: make,
        thumbnails: thumbnails(make),
        navigation: navigation(make)
      }
      collection[make] = Template.generate(template, template_values)

      collection
    end
  end

  def makes
    @works.map do |work|
      work.css('make').text
    end.uniq.reject(&:empty?)
  end

  def thumbnails(make)
    @works.select do |work|
      work.css('exif make').text == make
    end.map do |work|
      {
        src: work.css('urls url[type="small"]').text,
        alt: work.css('filename').text
      }
    end
  end

  def navigation(make)
    @works.select do |work|
      work.css('make').text == make
    end.map do |work|
      {
        href: '/' + ERB::Util.url_encode(work.css('exif model').text),
        text: work.css('exif model').text
      }
    end.unshift({href: '/', text: 'Home'})
  end
end
