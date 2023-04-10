require 'rails_helper'

RSpec.describe 'Customer Show Page' do
  describe 'Show page display' do
    before(:each) do
      supermarket_1 = Supermarket.create!(name: "Kroger", location: "145 Main St")
      item_1 = supermarket_1.item.create!(name: "Apple", price: 2)
      item_2 = supermarket_1.item.create!(name: "Banana", price: 1)
      customer = Customer.create!(name: "Henry")
      CustomerItem.create!(customer_id: customer.id, item_id: item_1.id)
      CustomerItem.create!(customer_id: customer.id, item_id: item_2.id)
      supermarket_2 = Supermarket.create!(name: "Walmart", location: "4738 Fast st")
      item_3 = supermarket_2.item.create!(name: "Cheese", price: 5)
      CustomerItem.create!(customer_id: customer.id, item_id: item_3)
    end
    it 'shows the name of the customer' do
      visit "/customers/#{customer.id}"

      expect(page).to have_content("Henry")
    end

    it 'displays list of items including item attributes and parent supermarket name' do
      visit "/customers/#{customer.id}"

      within('#items'){expect(page).to have_content("Items:")}

      within('#items'){expect(page).to have_content("Name: Apple")}
      within('#items'){expect(page).to have_content("Price: 2")}
      within('#items'){expect(page).to have_content("Available at: Kroger")}

      within('#items'){expect(page).to have_content("Name: Banana")}
      within('#items'){expect(page).to have_content("Price: 1")}
      within('#items'){expect(page).to have_content("Available at: Kroger")}

      within('#items'){expect(page).to have_content("Name: Cheese")}
      within('#items'){expect(page).to have_content("Price: 5")}
      within('#items'){expect(page).to have_content("Available at: Walmart")}
    end
  end
end