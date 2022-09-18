require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:phone) }
    it { should allow_value('$').for(:price) }
    it { should allow_value('$$').for(:price) }
    it { should allow_value('$$$').for(:price) }
    it { should allow_value('$$$$').for(:price) }
    it { should validate_presence_of(:category).allow_nil }
    it { should validate_numericality_of(:rating).allow_nil }
    it { should validate_presence_of(:rating).allow_nil }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many :events }
  end
end
