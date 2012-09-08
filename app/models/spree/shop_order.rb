module Spree
  class ShopOrder < ActiveRecord::Base

      attr_accessible :order_id, :line_items, :oredr_id, :line_items, :bill_address_attributes, :ship_address_attributes, :payments_attributes,
        :ship_address, :bill_address, :line_items_attributes, :number,
        :shipping_method_id, :email, :use_billing, :special_instructions, :shop_user_id,
        :item_total, :total, :state, :adjustment_total, :user_id, :completed_at, :bill_address_id, :ship_address_id, :payment_total, :shipment_state, :payment_state

  end
end
