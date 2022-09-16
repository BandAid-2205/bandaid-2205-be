require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :price }
    it { should validate_presence_of :category }
    it { should validate_presence_of :rating }
    it { should validate_numericality_of :rating }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many :events }
  end
end
