require 'rails_helper' 

RSpec.describe 'ArtistSearchFacade' do 
  it 'returns an ArtistPoro object', :vcr do 
    artist_info = ArtistSearchFacade.artist_search('dr.%20john')

    expect(artist_info).to be_an ArtistPoro
  end
end