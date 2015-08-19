require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'train system path', { type: :feature } do
  it "allows user to create a new train" do
    visit '/'
    click_link 'Trains'
    click_link 'Add Train'
    fill_in 'name', with: 'Steve'
    click_button 'Submit'
    expect(page).to have_content 'Steve'
  end

  it "allows user to create a new city" do
    visit '/'
    click_link 'Cities'
    click_link 'Add City'
    fill_in 'name', with: 'Portland'
    click_button 'Submit'
    expect(page).to have_content 'Portland'
  end

  it "allows user to create a new city and visit the city-entry" do
    @city = City.new({ id: nil, name: 'Portland' })
    @city.save
    visit '/cities'
    # click_link 'Cities'
    # click_link 'Add City'
    # fill_in 'name', with: 'Portland'
    # click_button 'Submit'
    click_link 'Portland'
    expect(page).to have_content 'we exist'
  end

  it "allows user to create a new train and visit the train-entry" do
    @train = Train.new({ id: nil, name: 'The_City_Of_New_Orleans' })
    @train.save
    visit '/trains'
    # click_link 'Cities'
    # click_link 'Add City'
    # fill_in 'name', with: 'Portland'
    # click_button 'Submit'
    click_link 'The_City_Of_New_Orleans'
    expect(page).to have_content 'we exist'
  end

end
