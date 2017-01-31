require 'oga'
require_relative '../lib/make_pages'

describe MakePages do
  let(:make_page) { MakePages.new(works) }
  let(:template) { File.read('lib/template.html.erb') }

  context 'given valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }

    let(:canon) { File.read('spec/fixtures/expected_makes/Canon.html') }
    let(:fujifilm) { File.read('spec/fixtures/expected_makes/FUJIFILM.html') }
    let(:fujifilmcoltd) { File.read('spec/fixtures/expected_makes/FUJIPHOTOFILMCOLTD.html') }
    let(:leica) { File.read('spec/fixtures/expected_makes/LEICA.html') }
    let(:nikon) { File.read('spec/fixtures/expected_makes/NIKONCORPORATION.html') }
    let(:panasonic) { File.read('spec/fixtures/expected_makes/Panasonic.html') }

    context 'calling generate' do
      let(:generate) { make_page.generate(template) }

      it 'should include a valid Canon page' do
        expect(generate['Canon.html']).to eq(canon)
      end

      it 'should include a valid FUJIFILM page' do
        expect(generate['FUJIFILM.html']).to eq(fujifilm)
      end

      it 'should include a valid FUJIPHOTOFILMCOLTD page' do
        expect(generate['FUJIPHOTOFILMCOLTD.html']).to eq(fujifilmcoltd)
      end

      it 'should include a valid LEICA page' do
        expect(generate['LEICA.html']).to eq(leica)
      end

      it 'should include a valid nikon page' do
        expect(generate['NIKONCORPORATION.html']).to eq(nikon)
      end

      it 'should include a valid Panasonic page' do
        expect(generate['Panasonic.html']).to eq(panasonic)
      end
    end
  end
end
