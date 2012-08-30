Spree::Admin::ProductsController.class_eval do
               
  def create
    @object.user_id = current_user.id
    super
  end

end
