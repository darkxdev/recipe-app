require 'rails_helper'
RSpec.describe 'Recipe index page Capybara integration test', type: :system do
  before :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
    @me = User.create(name: 'mohamed abd el mohsen saleh', email: 'mohamed20163858@gmail.com', password: 'momo123456')
    @me.confirm
    recipe1 = Recipe.create(name: 'pastsa', preparation_time: 15, cooking_time: 15,
                            description: 'very delicious recipe!', public: true, user: @me)
    food1 = Food.create(name: 'rice', measurement_unit: 'gram', price: 15, quantity: 500, user: @me)
    RecipeFood.create(recipe: recipe1, food: food1, quantity: 3)
  end
  after :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
  end
  it 'test seeing the foods page title' do
    sign_in @me
    visit foods_path
    sleep(1)
    expect(page).to have_content('Foods')
  end
  it 'test seeing the Food name' do
    sign_in @me
    visit foods_path
    sleep(1)
    expect(page).to have_content('rice')
  end

  it 'test seeing the Food delete button' do
    sign_in @me
    visit foods_path
    sleep(1)
    expect(page).to have_content('Delete')
  end
  it 'test clicking new food link' do
    sign_in @me
    visit foods_path
    sleep(1)
    click_link 'New food'
    expect(page).to have_current_path('/foods/new')
  end
  it 'test deleting the Food' do
    sign_in @me
    visit foods_path
    sleep(1)
    RecipeFood.destroy_all
    Recipe.destroy_all
    click_button 'Delete'
    expect(page).to_not have_content('gram')
  end
end
