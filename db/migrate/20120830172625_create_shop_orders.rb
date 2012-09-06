class CreateShopOrders < ActiveRecord::Migration
  def up

    create_table "spree_shop_orders", :force => true do |t|
      t.string   "number",               :limit => 15
      t.decimal  "item_total",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal  "total",                              :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string   "state"
      t.decimal  "adjustment_total",                   :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.integer  "user_id"
      t.datetime "created_at",                                                                        :null => false
      t.datetime "updated_at",                                                                        :null => false
      t.datetime "completed_at"
      t.integer  "bill_address_id"
      t.integer  "ship_address_id"
      t.decimal  "payment_total",                      :precision => 8, :scale => 2, :default => 0.0
      t.integer  "shipping_method_id"
      t.string   "shipment_state"
      t.string   "payment_state"
      t.string   "email"
      t.text     "special_instructions"
      t.integer  "product_user_id",                                                  :default => 0,   :null => false
    end

    add_index "spree_shop_orders", ["number"], :name => "index_spree_shop_orders_on_number"
    add_index "spree_shop_orders", ["user_id"], :name => "index_spree_shop_orders_on_user_id"
    add_index "spree_shop_orders", ["product_user_id"], :name => "index_spree_shop_orders_on_product_user_id"

  end

  def down
    drop_table :spree_shop_orders
  end
end
