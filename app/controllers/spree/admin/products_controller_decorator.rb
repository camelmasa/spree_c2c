Spree::Admin::ProductsController.class_eval do

  def create
    @object.user_id = current_user.id
    super
  end

  def collection
    return @collection if @collection.present?

    unless request.xhr?
      params[:q] ||= {}
      params[:q][:deleted_at_null] ||= "1"

      params[:q][:s] ||= "name asc"

      @search = super.ransack(params[:q])
      @collection = @search.result.
        group_by_products_id.
        includes([:master, {:variants => [:images, :option_values]}]).
        page(params[:page]).
        per(Spree::Config[:admin_products_per_page])

      if params[:q][:s].include?("master_price")
        # By applying the group in the main query we get an undefined method gsub for Arel::Nodes::Descending
        # It seems to only work when the price is actually being sorted in the query
        # To be investigated later.
        @collection = @collection.group("spree_variants.price")
      end
    else
      includes = [{:variants => [:images,  {:option_values => :option_type}]}, {:master => :images}]

      @collection = super.where(["name #{LIKE} ?", "%#{params[:q]}%"])
      @collection = @collection.includes(includes).limit(params[:limit] || 10)

      tmp = super.where(["#{Variant.table_name}.sku #{LIKE} ?", "%#{params[:q]}%"])
      tmp = tmp.includes(:variants_including_master).limit(params[:limit] || 10)
      @collection.concat(tmp)
    end

    roles = current_user.spree_roles.map do |role| role.name end
    return @collection.where(:user_id => current_user.id) unless roles.include?("admin")
    @collection
  end

end
