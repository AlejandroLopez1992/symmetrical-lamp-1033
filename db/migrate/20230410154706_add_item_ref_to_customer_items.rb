class AddItemRefToCustomerItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :customer_items, :item, foreign_key: true
  end
end
