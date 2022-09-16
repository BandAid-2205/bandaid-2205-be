require 'rails_helper' 

RSpec.describe 'Artist Poro' do 
  it 'exists and has proper Artist attributes' do 
    response = file_fixture('sample_artist_data.txt').read 

    data = JSON.parse(response, symbolize_names: true)

    artist = ArtistPoro.new(data)

    expect(artist).to be_an ArtistPoro
    expect(artist.name).to eq(data[:name])
    expect(artist.bio).to eq(data[:bio][:summary])
    tags = data[:tags][:tag].map { |tag| tag[:name] }
    expect(artist.genres).to eq(tags)
    expect(artist.image_path).to eq(data[:image][2][:"#text"])
  end
end