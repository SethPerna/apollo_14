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

    it '#alpha_missions' do
      neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
      bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
      buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')

      mission_1 = Mission.create!(title: "Gemini", time_in_space: 1)
      mission_2 = Mission.create!(title: "Apollo", time_in_space: 1)

      astro_mission_1 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_1.id)
      astro_mission_2 = AstronautMission.create!(astronaut_id: bob.id, mission_id: mission_1.id)
      astro_mission_3 = AstronautMission.create!(astronaut_id: buzz.id, mission_id: mission_2.id)
      astro_mission_4 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_2.id)

      expect(neil.alpha_missions).to eq([mission_2, mission_1])
    end

    it '#total_time_in_space' do
      neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
      bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
      buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')

      mission_1 = Mission.create!(title: "Gemini", time_in_space: 1)
      mission_2 = Mission.create!(title: "Apollo", time_in_space: 2)
      # neil 3, bob 1, buzz 2
      astro_mission_1 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_1.id)
      astro_mission_2 = AstronautMission.create!(astronaut_id: bob.id, mission_id: mission_1.id)
      astro_mission_3 = AstronautMission.create!(astronaut_id: buzz.id, mission_id: mission_2.id)
      astro_mission_4 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_2.id)

      expect(neil.total_time_in_space).to eq(3)
    end
  end
end
