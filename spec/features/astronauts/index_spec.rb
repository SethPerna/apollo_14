require 'rails_helper'

RSpec.describe "astronauts index page" do
  it "I see a list of astronauts with name age and job" do
    neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
    bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
    buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')
    visit '/astronauts'

    expect(page).to have_content("Name: #{neil.name}")
    expect(page).to have_content("Age: #{neil.age}")
    expect(page).to have_content("Job: #{neil.job}")
    expect(page).to have_content("Name: #{bob.name}")
    expect(page).to have_content("Age: #{bob.age}")
    expect(page).to have_content("Job: #{bob.job}")
    expect(page).to have_content("Name: #{buzz.name}")
    expect(page).to have_content("Age: #{buzz.age}")
    expect(page).to have_content("Job: #{buzz.job}")
  end

  it 'had average age of all astronauts' do
    neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
    bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
    buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')
    visit '/astronauts'

    expect(page).to have_content("Average Age: #{Astronaut.average_age}")
  end

  it 'has a list of the space missions in alphabetical order' do
    neil = Astronaut.create!(name: 'neil', age: 1, job: 'pilot')
    bob = Astronaut.create!(name: 'bob', age: 2, job: 'commander')
    buzz = Astronaut.create!(name: 'buzz', age: 3, job: 'co-pilot')

    mission_1 = Mission.create!(title: "Gemini", time_in_space: 1)
    mission_2 = Mission.create!(title: "Apollo", time_in_space: 1)

    astro_mission_1 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_1.id)
    astro_mission_2 = AstronautMission.create!(astronaut_id: bob.id, mission_id: mission_1.id)
    astro_mission_3 = AstronautMission.create!(astronaut_id: buzz.id, mission_id: mission_2.id)
    astro_mission_4 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission_2.id)

    visit '/astronauts'

    within ".astronaut-#{neil.id}" do
      expect(page).to have_content(mission_1.title)
      expect(page).to have_content(mission_2.title)
      expect(mission_2.title).to appear_before(mission_1.title)
    end
  end

#   User Story 4 of 4
#
# As a visitor,
# When I visit '/astronauts'
# I see the total time in space for each astronaut.
# (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 760 days")

  it 'has total tiem in space for each astronaut' do
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

    visit '/astronauts'
    
    within ".astronaut-#{neil.id}" do
      expect(page).to have_content("Time in space: 3")
    end
    within ".astronaut-#{bob.id}" do
      expect(page).to have_content("Time in space: 1")
    end
    within ".astronaut-#{buzz.id}" do
      expect(page).to have_content("Time in space: 2")
    end
  end
end
