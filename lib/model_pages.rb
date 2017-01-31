require 'erb'
require_relative 'template'

# All things required to generate the ModelPages
class ModelPages
  def initialize(works)
    @works = works
  end

  def generate(template)
    models.each_with_object({}) do |model, collection|
      template_values = {
        title: model,
        thumbnails: thumbnails(model),
        navigation: navigation(model)
      }
      collection[model] = Template.generate(template, template_values)

      collection
    end
  end

  def models
    @works.map { |work| work.css('model').text }.uniq.reject(&:empty?)
  end

  def thumbnails(model)
    @works.select { |work| work.css('model').text == model }.map do |work|
      {
        src: work.css('urls url[type="small"]').text,
        alt: work.css('filename').text
      }
    end
  end

  def navigation(model)
    home_link = [{ href: '/', text: 'Home' }]

    make_links = @works.select { |work| work.css('model').text == model }.map do |work|
      {
        href: '/' + ERB::Util.url_encode(work.css('make').text),
        text: work.css('make').text
      }
    end

    home_link + make_links
  end
end
