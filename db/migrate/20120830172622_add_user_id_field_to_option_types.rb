class AddUserIdFieldToOptionTypes < ActiveRecord::Migration
  def up
    add_column :spree_option_types, :user_id, :integer, :default => 0, :null => false
    add_index "spree_option_types", ["user_id"], :name => "index_spree_option_types_on_user_id"
  end

  def down
    remove_column :spree_option_types , :user_id
  end
end
