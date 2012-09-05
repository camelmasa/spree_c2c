Spree::Admin::ResourceController.class_eval do

  before_filter :variable_set_user_id, :only => [:create]
  before_filter :only_own_products

  def variable_set_user_id

    # TODO
    # some display bug
    
    @object.user_id = current_user.id
  end

  def only_own_products
    controller_names = ['images', 'variants', 'product_properties']
    return if !controller_names.include?(controller_name)

    @product = Spree::Product.where(:permalink => params[:product_id]).first
    return head(401) if !admin? && @product.user_id != current_user.id
  end

  def load_resource
    if member_action?
      @object ||= load_resource_instance
      return head(401) if !admin? && (!@object.user_id.zero? && @object.user_id != current_user.id)
      instance_variable_set("@#{object_name}", @object)
    else
      @collection ||= collection
      controller_names = ['variants']
      @collection = @collection.where(:user_id => current_user.id) if !admin? && !controller_names.include?(controller_name)
      instance_variable_set("@#{controller_name}", @collection)
    end
  end

end
