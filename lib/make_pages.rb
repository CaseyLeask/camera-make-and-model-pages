require 'erb'
require_relative 'template'

# All things required to generate the MakePages
class MakePages
  def initialize(works)
    @works = works
  end

  def generate(template)
    makes.each_with_object({}) do |make, collection|
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
    @works.map { |work| work.css('make').text }.uniq.reject(&:empty?)
  end

  def thumbnails(make)
    @works.select { |work| work.css('make').text == make }.map do |work|
      {
        src: work.css('urls url[type="small"]').text,
        alt: work.css('filename').text
      }
    end
  end

  def navigation(make)
    home_link = [{ href: '/', text: 'Home' }]

    make_links = @works.select { |work| work.css('make').text == make }.map do |work|
      {
        href: '/' + ERB::Util.url_encode(work.css('model').text),
        text: work.css('model').text
      }
    end

    home_link + make_links
  end
end
