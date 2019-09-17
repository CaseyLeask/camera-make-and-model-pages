# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'oga'
require_relative 'index_page'
require_relative 'make_pages'
require_relative 'model_pages'

# Used to parse the API XML
class Parser
  def self.parse(api_url)
    document = Oga.parse_xml(Net::HTTP.get(api_url))
    works = document.css('works work')

    template = File.read('lib/template.html.erb')

    index_page = IndexPage.new(works).generate(template)
    make_pages = MakePages.new(works).generate(template)
    model_pages = ModelPages.new(works).generate(template)

    index_page.merge(make_pages).merge(model_pages)
  end
end
