Spree::Admin::ResourceController.class_eval do

  def c2c_create
    @object.user_id = current_user.id
  end

  def c2c_load_resource
    roles = current_user.spree_roles.map do |role| role.name end
    if member_action?
      @object ||= load_resource_instance
      @object = @object.where(:user_id => current_user.id) unless roles.include?("admin")
      instance_variable_set("@#{object_name}", @object)
    else
      @collection ||= collection
      @collection = @collection.where(:user_id => current_user.id) unless roles.include?("admin")
      instance_variable_set("@#{controller_name}", @collection)
    end
  end

end
