Spree::Admin::PrototypesController.class_eval do

  def create
    c2c_create
    super
  end

  def new
    c2c_form
    super
  end

  def edit
    c2c_form
    super
  end

  def c2c_form
    @option_types = Spree::OptionType
    @option_types = admin? ? @option_types.all : @option_types.where(:user_id => current_user.id)
    @properties   = Spree::Property
    @properties   = admin? ? @properties.all : @properties.where(:user_id => current_user.id)
  end

end
