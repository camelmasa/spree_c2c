class AddUserIdFieldToPrototypes < ActiveRecord::Migration
  def up
    add_column :spree_prototypes, :user_id, :integer, :default => 0, :null => false
    add_index "spree_prototypes", ["user_id"], :name => "index_spree_prototypes_on_user_id"
  end

  def down
    remove_column :spree_prototypes , :user_id
  end
end
