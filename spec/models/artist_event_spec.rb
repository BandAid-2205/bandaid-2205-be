require 'rails_helper'

RSpec.describe ArtistEvent, type: :model do
  describe 'relationships' do
    it { should belong_to :event }
    it { should belong_to :artist }
  end
end
