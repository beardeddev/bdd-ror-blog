class Admin::CommentsController < DashboardController
  
  before_filter :find_comment, :only => [:show, :edit, :update]

  private
    def find_comment      
      @comment = Comment.find(params[:id])
    end
    
  public
  def index
    @filter = ActiverecordFilter.new(Comment, params)    
    @comments = Comment.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @comments }
    end
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save      
        flash[:notice] = 'Комментарий успешно сохранен.'
        format.html { redirect_to edit_admin_comment_path(@comment) }
        format.xml  { render :xml => @comment, :status => :created,
                    :location => [:admin, @comment] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Комментарий успешно сохранен.'
        format.html { redirect_to edit_admin_comment_path(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        if request.xhr?
          render :inline => @comment.body, :layout => false
        end
      }
      format.xml  { render :xml => @comment }
    end
  end
  
  def destroy    
    respond_to do |format|
      if request.delete?
        find_comment
        @comment.destroy                    
      else
        params[:ids].each do |id|
          comment = Comment.find(id)
         comment.destroy
        end
      end
      flash[:notice] = 'Комментарий успешно удален.'
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }    
    end
  end
  
end
