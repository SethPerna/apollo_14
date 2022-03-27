require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:missions).through(:astronaut_missions) }
  end

  describe 'instance and class methods' do
    it '.average_age' do
      neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
      bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
      buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')

      expect(Astronaut.average_age).to eq(2)
    end
  end
end
