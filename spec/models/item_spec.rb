require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items}
    it { should have_many(:customers).through(:customer_items)}
  end

  describe 'instance methods' do
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

    it 'count_of_customer_items gives count of customer items' do
      expect(@item_1.count_of_customer_items).to eq(3)
      expect(@item_2.count_of_customer_items).to eq(1)
      expect(@item_3.count_of_customer_items).to eq(1)
      expect(@item_4.count_of_customer_items).to eq(1)
      expect(@item_4.count_of_customer_items).to eq(0)
    end
  end
end
