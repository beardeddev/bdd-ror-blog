class Admin::MenuController < DashboardController

  before_filter :find_link, :only => [:show, :edit, :update]

  private
    def find_link
      @link = Menu.find(params[:id])
    end

  public
  def index
    @filter = ActiverecordFilter.new(Menu, params)
    @links = Menu.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @links }
    end
  end

  def new
    @link = Menu.new
  end

  def create
    @link = Menu.new(params[:menu])
    respond_to do |format|
      if @link.save
        flash[:notice] = 'Ссылка успешно сохранена.'
        format.html { redirect_to edit_admin_menu_path(@link) }
        format.xml  { render :xml => @link, :status => :created,
                    :location => [:admin, @link] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @link.update_attributes(params[:menu])
        flash[:notice] = 'Ссылка успешно сохранена.'
        format.html { redirect_to edit_admin_menu_path(@link) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    respond_to do |format|
      if request.delete?
        find_link
        @link.destroy
      else
        params[:ids].each do |id|
          link = Menu.find(id)
         link.destroy
        end
      end
      flash[:notice] = 'Ссылка успешно удалена.'
      format.html { redirect_to(admin_links_url) }
      format.xml  { head :ok }
    end
  end

end

