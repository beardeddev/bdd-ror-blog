class Admin::TagsController < DashboardController
    
  before_filter :find_tag, :only => [:show, :edit, :update]
  
  private
    def find_tag      
      @tag = Tag.find(params[:id])
    end
    
  public
  def index
    @filter = ActiverecordFilter.new(Tag, params)    
    @tags = Tag.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @tags }
    end
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      if @tag.save      
        flash[:notice] = 'Тег успешно сохранен.'
        format.html { redirect_to edit_admin_tag_path(@tag) }
        format.xml  { render :xml => @tag, :status => :created,
                    :location => [:admin, @tag] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Тег успешно сохранен.'      
        format.html { redirect_to edit_admin_tag_path(@tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
  end
  
  def destroy
    respond_to do |format|
      if request.delete?
         find_tag
        @tag.destroy                    
      else
        params[:ids].each do |id|
          @tag = Tag.find(id)
          @tag.destroy
        end
      end
      flash[:notice] = 'Тег успешно удален.'
      format.html { redirect_to(admin_tags_url) }
      format.xml  { head :ok }    
    end
  end
  
end
