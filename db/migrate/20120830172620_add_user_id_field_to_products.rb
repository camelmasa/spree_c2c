class AddUserIdFieldToProducts < ActiveRecord::Migration
  def up
    add_column :spree_products, :user_id, :integer, :default => 0, :null => false
    add_index "spree_products", ["user_id"], :name => "index_spree_orders_on_user_id"
  end

  def down
    remove_column :spree_products, :user_id
  end
end
