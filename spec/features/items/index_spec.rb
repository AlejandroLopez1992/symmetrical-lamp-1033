require 'rails_helper'

RSpec.describe 'Items Index Page' do
  describe 'Items page display' do
    before(:each) do
      @supermarket_1 = Supermarket.create!(name: "Kroger", location: "145 Main St")
      @item_1 = @supermarket_1.items.create!(name: "Apple", price: 2)
      @item_2 = @supermarket_1.items.create!(name: "Banana", price: 1)
      @customer = Customer.create!(name: "Henry")
      CustomerItem.create!(customer_id: @customer.id, item_id: @item_1.id)
      CustomerItem.create!(customer_id: @customer.id, item_id: @item_2.id)
      @supermarket_2 = Supermarket.create!(name: "Walmart", location: "4738 Fast st")
      @item_3 = @supermarket_2.items.create!(name: "Cheese", price: 5)
      CustomerItem.create!(customer_id: @customer.id, item_id: @item_3.id)
      @item_4 = @supermarket_2.items.create!(name: "Ham", price: 7)
      @customer_2 = Customer.create!(name: "Stevo")
      CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_4.id)
      @customer_3 = Customer.create!(name: "Bob")
      CustomerItem.create!(customer_id: @customer_3.id, item_id: @item_1.id)
      CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_1.id)
      @item_5 = @supermarket_2.items.create!(name: "Stove", price: 700)

    end
    it 'displays all items with their base attributes' do
      visit "/items"
      
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_content(@item_1.supermarket.name)

      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.price)
      expect(page).to have_content(@item_2.supermarket.name)

      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.price)
      expect(page).to have_content(@item_3.supermarket.name)

      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.price)
      expect(page).to have_content(@item_4.supermarket.name)

      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.price)
      expect(page).to have_content(@item_5.supermarket.name)
    end

    it "displays count of customers that have bought each item" do
      visit "/items"

      expect(@item_1.customer_items.count).to eq(3)
      expect(page).to have_content("Count of Apple bought: 3")

      expect(@item_2.customer_items.count).to eq(1)
      expect(page).to have_content("Count of Banana bought: 1")

      expect(@item_3.customer_items.count).to eq(1)
      expect(page).to have_content("Count of Cheese bought: 1")

      expect(@item_4.customer_items.count).to eq(1)
      expect(page).to have_content("Count of Ham bought: 1")

      expect(@item_4.customer_items.count).to eq(0)
      expect(page).to have_content("Count of Stove bought: 0")
    end
  end
end