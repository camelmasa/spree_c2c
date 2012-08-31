Spree::Admin::BaseController.class_eval do

  def admin?
    roles = current_user.spree_roles.map do |role| role.name end
    roles.include?("admin")
  end

end
