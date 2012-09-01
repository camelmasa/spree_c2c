Spree::Admin::PrototypesController.class_eval do

  before_filter :variable_set_form_options, :only => [:new, :edit]

  def variable_set_form_options
    @option_types = Spree::OptionType
    @option_types = admin? ? @option_types.all : @option_types.where(:user_id => current_user.id)
    @properties   = Spree::Property
    @properties   = admin? ? @properties.all : @properties.where(:user_id => current_user.id)
  end

end
