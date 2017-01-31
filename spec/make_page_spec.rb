require 'oga'
require_relative '../lib/make_pages'

describe MakePages do
  let(:make_page) { MakePages.new(works) }
  let(:template) { File.read('lib/template.html.erb') }

  context 'given valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }
    let(:nikon) do
      File.read('spec/fixtures/expected_makes/nikon.html')
    end

    context 'calling generate' do
      let(:generate) { make_page.generate(template) }

      it 'should include a valid nikon page' do
        expect(generate['NIKON%20CORPORATION.html']).to eq(nikon)
      end
    end
  end
end
