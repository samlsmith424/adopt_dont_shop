require 'rails_helper'

RSpec.describe 'application show page' do
  it 'diplays the applicants name and attributes' do
    applicant_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I love pets")
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
    PetApplication.create!(pet_id: pet_1.id, application_id: applicant_1.id)
    PetApplication.create!(pet_id: pet_2.id, application_id: applicant_1.id)

    visit "/applications/#{applicant_1.id}"

    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content(applicant_1.address)
    expect(page).to have_content(applicant_1.city)
    expect(page).to have_content(applicant_1.state)
    expect(page).to have_content(applicant_1.zipcode)
    expect(page).to have_content(applicant_1.description)
    expect(page).to have_content(applicant_1.status)
    expect(page).to have_link(pet_1.name)
  end

  it 'has links to each pets show page' do
    applicant_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I love pets")
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
    PetApplication.create!(pet_id: pet_1.id, application_id: applicant_1.id)
    PetApplication.create!(pet_id: pet_2.id, application_id: applicant_1.id)

    visit "/applications/#{applicant_1.id}"

    click_link "#{pet_1.name}"

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it 'has a section to add pet to application if the application is not submitted' do
    applicant_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I love pets")
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
    pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
    # PetApplication.create!(pet_id: pet_1.id, application_id: applicant_1.id)
    # PetApplication.create!(pet_id: pet_2.id, application_id: applicant_1.id)

    visit "/applications/#{applicant_1.id}"

    expect(page).to have_content("Add a Pet to this Application")
    save_and_open_page
    # fill_in('Search pet by name', with: 'Pork Chop')
    fill_in :search, with: "Pork Chop"
    click_button('Search')
    expect(current_path).to eq("/applications/#{applicant_1.id}")

    within('#pet-results') do
      expect(page).to have_content('Pork Chop')
    end
    # fill_in("Add a Pet to this Application")
  end
end
