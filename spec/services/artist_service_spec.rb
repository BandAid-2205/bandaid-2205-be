require 'rails_helper' 

RSpec.describe 'ArtistService' do 
  it 'retrieves Artist data that matches search query' do 
    parsed_json = ArtistService.search_artist('the radiators')

    expect(parsed_json).to be_a Hash 
    expect(pased_json[:artist]).to be_an Array 

    sample_data = parsed_json[:artists].first

    expect(sample_data).to include(:name, :bio, :summary, :tags, :tag, :name, :image, :"#text")

    expect(sample_data[:name]).to be_a String
    expect(sample_data[:bio][:summary]).to be_a String
    expect(sample_data[:tags][:tag][0][:name]).to be_a String
    expect(sample_data[:image][2][:"#text"]).to be_a String
  end
end