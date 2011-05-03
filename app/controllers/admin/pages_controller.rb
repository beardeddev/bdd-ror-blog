class Admin::PagesController < DashboardController
  
  before_filter :find_page, :only => [:show, :edit, :update]
  
  private
    def find_page      
      @page = Page.find(params[:id])
    end
    
  public
  def index
    @filter = ActiverecordFilter.new(Page, params)    
    @pages = Page.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save      
        flash[:notice] = 'Страница успешно сохранена.'
        format.html { redirect_to edit_admin_page_path(@page) }
        format.xml  { render :xml => @page, :status => :created,
                    :location => [:admin, @page] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Страница успешно сохранена.'      
        format.html { redirect_to edit_admin_page_path(@page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
  end
  
  def destroy    
    respond_to do |format|
      if request.delete?
        find_page
        @page.destroy                    
      else
        params[:ids].each do |id|
          page = Page.find(id)
         page.destroy
        end
      end
      flash[:notice] = 'Страница успешно удалена.'
      format.html { redirect_to(admin_pages_url) }
      format.xml  { head :ok }    
    end
  end
  
end
