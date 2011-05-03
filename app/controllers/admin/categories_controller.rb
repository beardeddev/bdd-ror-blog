class Admin::CategoriesController < DashboardController
  
  before_filter :find_category, :only => [:show, :edit, :update]
  
  private
  def find_category      
    @category = Category.find(params[:id])
  end
  
  public
  def index
    @filter = ActiverecordFilter.new(Category, params)    
    @categories = Category.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @categories }
    end
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    respond_to do |format|
      if @category.save      
        flash[:notice] = 'Категория успешно сохранена.'
        format.html { redirect_to edit_admin_category_path(@category) }
        format.xml  { render :xml => @category, :status => :created,
                    :location => [:admin, @category] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Категория успешно сохранена.'      
        format.html { redirect_to edit_admin_category_path(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
  end
  
  def destroy
    respond_to do |format|
      if request.delete?
        find_category
        @category.destroy                    
      else
        params[:ids].each do |id|
          @category = Category.find(id)
          @category.destroy
        end
      end
      flash[:notice] = 'Категория успешно удалена.'
      format.html { redirect_to(admin_categories_url) }
      format.xml  { head :ok }    
    end
  end
  
end
