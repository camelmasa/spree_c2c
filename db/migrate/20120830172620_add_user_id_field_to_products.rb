class AddUserIdFieldToProducts < ActiveRecord::Migration
  def up
    add_column :spree_products, :user_id, :integer, :default => 0, :null => false
  end

  def down
    remove_column :spree_products, :user_id
  end
end
