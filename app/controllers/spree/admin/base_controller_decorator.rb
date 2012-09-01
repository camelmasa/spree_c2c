Spree::Admin::BaseController.class_eval do

  before_filter :only_admin_role

  def only_admin_role

    controller_names = ['reports', 'configurations', 'general_settings', 'mail_methods', 'tax_categories', 'zones', 'countries', 'states',  'payment_methods', 'taxonomies', 'shipping_methods', 'shipping_categories', 'inventory_settings', 'image_settings', 'tax_rates', 'tax_settings', 'trackers', 'promotions', 'users']

    return head(401) if !admin? && controller_names.include?(controller_name)

  end

  def admin?
    roles.include?("admin")
  end

  def seller?
    return true if admin?
    roles.include?("seller")
  end

  private
    
    def roles
      current_user.spree_roles.map do |role| role.name end
    end

end
