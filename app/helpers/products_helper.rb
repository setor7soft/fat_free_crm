module ProductsHelper

  def brief_product_info(product)
    text = ""
    name = product.name
    manufacturer = product.manufacturer
    price = product.price
    account_text = ""
    account_text = link_to_if(can?(:read, product), h(product.code), product_path(product)) if product.present?

    text << if name.present? && price.present? && manufacturer.present?
          t(:product_with_name_price_manufacturer, :name => h(name), :price => h(price), :manufacturer => h(manufacturer))
        elsif name.present? && price.present?
          t(:product_with_name_price, :name => h(name), :price => h(price))
        elsif name.present?
          t(:product_with_name, :name => h(name))
        else
          ""
        end
    text.html_safe
  end

  # Output account with title and department
  # - a helper so it is easy to override in plugins that allow for several accounts
  #----------------------------------------------------------------------------
  def product_with_code_and_manufacturer(product)
    text = if product.code.present? && product.manufacturer.present?
        tempStr = ""
        tempStr << "<b>#{t(:code)}:</b> #{product.code}<br>"
        tempStr << "<b>#{t(:manufacturer)}:</b> #{product.manufacturer}<br>"
        tempStr
      elsif  product.code.present?
        "<b>#{t(:code)}:</b> #{product.code}<br>"
      elsif product.manufacturer.present?
        "<b>#{t(:manufacturer)}:</b> #{product.manufacturer}<br>"
      else
        ""
      end
    text.html_safe
  end

  def product_stage_checkbox(stage, count)
    entity_filter_checkbox(:stage, stage, count)
  end

  #----------------------------------------------------------------------------
  def products_for_index(model)
    model.class.to_s.constantize.find(model.id).products.inject([]) do |arr, product|
      arr << link_to(product.name, product_path(product))
    end.join(", ").html_safe
  end

  # Generate the collection select for edit
  #----------------------------------------------------------------------------
  def get_products_colletion_select
    model = self.controller_name.singularize
    @product = Product.find(:all)
    collection_select( model,
                       :product_ids,
                       @product ,
                       :id,
                       :name,
                       { },
                       { :multiple => true, :size => '10', :style => "width:100%", :class => 'select2' })

  end

end
