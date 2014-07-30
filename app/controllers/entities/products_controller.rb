class ProductsController < EntitiesController
  before_filter :load_settings
  before_filter :set_current_tab
  before_filter :auto_complete, :only => :auto_complete
  before_filter :get_data_for_sidebar, :only => [:index, :create]
  before_filter :set_params, :only => [ :index, :redraw, :filter ]

  # GET /products
  # GET /products.xml                                                   HTML
  #----------------------------------------------------------------------------
  def index
    @products = get_products(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/new
  # GET /products/new.xml                                               AJAX
  #----------------------------------------------------------------------------
  def new
    @product = Product.new()
    @product.attributes = {:stage => Product.default_stage}
    respond_to do |format|
      format.js   # new.js.rjs
      format.xml  { render :xml => @product }
    end
  end

  # GET /contacts/1
  # AJAX /contacts/1
  #----------------------------------------------------------------------------
  def show
    @comment = Comment.new
    @timeline = timeline(@product)
    respond_with(@product)
  end

  # GET /products/1/edit                                                AJAX
  #----------------------------------------------------------------------------
  def edit
    @product = Product.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = Product.find($1)
    end

  rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @product
  end

  # POST /products
  # POST /products.xml                                                  AJAX
  #----------------------------------------------------------------------------
  def create
    @product = Product.new(product_params)
    respond_with(@product) do |format|
      loginputs @product
      if @product.save(product_params)
        loginputs called_from_index_page?
        @products = get_products if called_from_index_page?
        loginputs @products
      end
    end

  end

  def product_params
    params.require(:product)#.permit(:avatar)
  end

  def loginputs(obj)
    puts '################____INICIO____################'
    puts obj.inspect
    puts '################____FIM____################'
  end

  # PUT /products/1
  # PUT /products/1.xml                                                 AJAX
  #----------------------------------------------------------------------------
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.js   # update.js.rjs
        format.xml  { head :ok }
      else
        format.js   # update.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # GET /products/1/confirm                                             AJAX
  #----------------------------------------------------------------------------
  def confirm
    @product = Product.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # DELETE /products/1
  # DELETE /products/1.xml                                              AJAX
  #----------------------------------------------------------------------------
  def destroy
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.destroy
        format.js   # destroy.js.rjs
        format.xml  { head :ok }
      else
        flash[:warning] = t(:msg_cant_delete_product, @product.name)
        format.js   # destroy.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def redraw
    current_user.pref[:products_per_page] = params[:per_page] if params[:per_page]

    # Sorting and naming only: set the same option for Leads if the hasn't been set yet.
    if params[:sort_by]
      current_user.pref[:products_sort_by] = Product::sort_by_map[params[:sort_by]]
    end
    if params[:naming]
      current_user.pref[:products_naming] = params[:naming]
    end

    @products = get_products(:page => 1, :per_page => params[:per_page]) # Start on the first page.
    set_options # Refresh options

    respond_with(@products) do |format|
      format.js { render :index }
    end
  end

  def load_settings
    @stage = Setting.unroll(:product_stage)
  end

  def get_data_for_sidebar(related = false)
    if related
      instance_variable_set("@#{related}", @product.send(related)) if called_from_landing_page?(related.to_s.pluralize)
    else
      @product_stage_total = { :all => Product.my.count, :other => 0 }
      @stage.each do |value, key|
        @product_stage_total[key] = Product.my.where(:stage => key.to_s).count
        @product_stage_total[:other] -= @product_stage_total[key]
      end
      @product_stage_total[:other] += @product_stage_total[:all]
    end
  end

  # POST /opportunities/filter                                             AJAX
  #----------------------------------------------------------------------------
  def filter
    @products = get_products(:page => 1, :per_page => params[:per_page])
    respond_with(@products) do |format|
      format.js { render :index }
    end
  end

  #----------------------------------------------------------------------------
  def set_params
    current_user.pref[:products_per_page] = params[:per_page] if params[:per_page]
    current_user.pref[:products_sort_by]  = Product::sort_by_map[params[:sort_by]] if params[:sort_by]
    session[:products_filter] = params[:stage] if params[:stage]
  end

  private
  #----------------------------------------------------------------------------
  alias :get_products :get_list_of_records

end
