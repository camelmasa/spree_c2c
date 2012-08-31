Spree::Admin::ResourceController.class_eval do

  def load_resource
    if member_action?
      @object ||= load_resource_instance
      return head(400) if !admin? && (@object.user_id != 0 && @object.user_id != current_user.id)
      instance_variable_set("@#{object_name}", @object)
    else
      @collection ||= collection
      @collection = @collection.where(:user_id => current_user.id) unless admin?
      instance_variable_set("@#{controller_name}", @collection)
    end
  end

end
