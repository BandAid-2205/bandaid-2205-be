require 'rails_helper' 

RSpec.describe 'ArtistSearchFacade' do 
  it 'returns an ArtistPoro object', :vcr do 
    artist_info = ArtistSearchFacade.artist_search('dr.%20john')

    expect(artist_info).to be_an ArtistPoro
  end

  it 'returns an error message if artist is not returned', :vcr do 
    artist_info = ArtistSearchFacade.artist_search('fjdks')

    expect(artist_info).to eq({:error => 6, :message => "The artist you supplied could not be found", :links  =>[]})
  end
end