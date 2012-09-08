Spree::Admin::OrdersController.class_eval do


  def index
    params[:q] ||= {}
    params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
    @show_only_completed = params[:q][:completed_at_not_null].present?
    params[:q][:s] ||= @show_only_completed ? 'completed_at desc' : 'created_at desc'

    # As date params are deleted if @show_only_completed, store
    # the original date so we can restore them into the params
    # after the search
    created_at_gt = params[:q][:created_at_gt]
    created_at_lt = params[:q][:created_at_lt]

    params[:q].delete(:inventory_units_shipment_id_null) if params[:q][:inventory_units_shipment_id_null] == "0"

    if !params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
    end

    if !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    if @show_only_completed
      params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
      params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
    end

    @search = admin? ? Spree::Order.ransack(params[:q]) : Spree::Order.joins(:shop_orders).where("spree_shop_orders.shop_user_id = #{current_user.id}").ransack(params[:q])

    @orders = @search.result(:distinct => true).includes([:user, :shipments, :payments]).page(params[:page]).per(Spree::Config[:orders_per_page])

    # Restore dates
    params[:q][:created_at_gt] = created_at_gt
    params[:q][:created_at_lt] = created_at_lt

    respond_with(@orders)
  end

  def new
    @order = Spree::Order.create(:shop_user_id => current_user.id)
    respond_with(@order)
  end

  def load_order
    @order = Spree::Order.find_by_number!(params[:id], :include => :adjustments) if params[:id]
    return head(401) if @order && !admin? && @order.shop_user_id != current_user.id
  end

end

