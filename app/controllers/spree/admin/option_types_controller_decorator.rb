Spree::Admin::OptionTypesController.class_eval do

  def create
    c2c_create
    super
  end

  def index
    c2c_load_resource
  end

end
