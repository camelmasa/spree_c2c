class AddProductUserIdFieldToOrders < ActiveRecord::Migration
  def up
    add_column :spree_orders, :product_user_id, :integer, :default => 0, :null => false
    add_index "spree_orders", ["product_user_id"], :name => "index_spree_orders_on_product_user_id"
  end

  def down
    remove_column :spree_orders , :prduct_user_id
  end
end
