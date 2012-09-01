Spree::Admin::BaseController.class_eval do

  def admin?
    roles.include?("admin")
  end

  def seller?
    return true if admin?
    roles.include?("seller")
  end

  def check_admin
    return head(400) if !admin?
  end

  private
    
    def roles
      current_user.spree_roles.map do |role| role.name end
    end

end
