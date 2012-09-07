Spree::CheckoutController.class_eval do

  after_filter :after_save_complete_order, :only => :update

  def after_save_complete_order
    return if @order.state != "complete"
    user_ids = @order.products.map {|p| p.user_id }.uniq
    
    user_ids.each do |user_id|

      shop_order = Spree::ShopOrder.create(
        :order_id => @order.id,
        :number => @order.number,
        :state => @order.state,
        :user_id => @order.user_id,
        :completed_at => @order.completed_at,
        :bill_address_id => @order.bill_address_id,
        :ship_address_id => @order.ship_address_id,
        :payment_total => @order.payment_total,
        :shipping_method_id => @order.shipping_method_id,
        :shipment_state => @order.shipment_state,
        :payment_state => @order.payment_state,
        :email => @order.email,
        :special_instructions => @order.special_instructions,
        :shop_user_id => user_id
      )
      
      item_total = 0
      line_items = Spree::LineItem.where(:order_id => shop_order.order_id)
      line_items.map{|li| li.variant.product.user_id == user_id ? li.variant.price : 0}.each{|x|item_total += x}
      p item_total
      shop_order.update_attributes(
        :item_total => item_total,
        :total => item_total + @order.adjustment_total,
        :adjustment_total => @order.adjustment_total,
      )

    end

  end

end
