class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def count_of_customer_items
    self.customer_items.count
  end
  
end