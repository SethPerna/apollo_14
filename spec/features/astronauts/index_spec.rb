require 'rails_helper'
# User Story 1 of 4
#
# As a visitor,
# When I visit '/astronauts'
# I see a list of astronauts with the following info:
# - Name
# - Age
# - Job
#
# (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander")
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
end
