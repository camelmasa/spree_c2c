Deface::Override.new(:virtual_path => "spree/admin/prototypes/_form", 
                     :name => "c2c_admin_properties_form_fields", 
                     :replace_contents => "#properties[data-hook]",
                     :text => '<% @properties.each do |property| %>
                                 <% selected = if @prototype.new_record?
                                 (params[:property] and params[:property][:id] and params[:property][:id].include?(property.id.to_s))
                                 else
                                   @prototype.properties.include?(property)
                                 end %>
                                 <li>
                                 <label>
                                 <%= check_box_tag "property[id][]", "#{property.id}", selected %>
                                 <%= property.name %>
                                 </label>
                                 </li>
                               <% end %>',
                     :disabled => false)
Deface::Override.new(:virtual_path => "spree/admin/prototypes/_form", 
                     :name => "c2c_admin_prototype_form_fields", 
                     :replace_contents => "#option_types[data-hook]",
                     :text => '<% @option_types.each do |option_type| %>
                       <% selected = if @prototype.new_record?
                     (params[:option_type] and params[:option_type][:id] and params[:option_type][:id].include?(option_type.id.to_s))
                     else
                       @prototype.option_types.include?(option_type)
                     end %>
                     <li>
                     <label>
                     <%= check_box_tag "option_type[id][]", "#{option_type.id}", selected %>
                     <%= option_type.name %>
                     </label>
                     </li>
                     <% end %>',
                     :disabled => false)
