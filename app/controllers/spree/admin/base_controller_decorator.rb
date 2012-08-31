Spree::Admin::BaseController.class_eval do

  def c2c_create
    @object.user_id = current_user.id
  end

  def admin?
    roles = current_user.spree_roles.map do |role| role.name end
    roles.include?("admin")
  end

end
