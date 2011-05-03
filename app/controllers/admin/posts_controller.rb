class Admin::PostsController < DashboardController
  before_filter :find_post, :only => [:show, :edit, :update]
  before_filter :find_categories, :only => [:edit, :new, :create, :update]
  after_filter  :link_categories, :only => [:update, :create]
  
  private
  def find_post
    @post = Post.find(params[:id])
  end

  def find_categories
    @categories = Category.all
  end

  def link_categories
    ids = params[:categories] || []
    @post.category_ids = ids
  end
    
  public
  def index
    @filter = ActiverecordFilter.new(Post, params)
    @posts = Post.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @posts }
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post].merge(:user_id => @current_user.id))
    respond_to do |format|
      if @post.save      
        flash[:notice] = 'Пост успешно сохранен.'
        format.html { redirect_to edit_admin_post_path(@post) }
        format.xml  { render :xml => @post, :status => :created,
                    :location => [:admin, @post] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Пост успешно сохранен.'      
        format.html { redirect_to edit_admin_post_path(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
  end
  
  def destroy
    respond_to do |format|
      if request.delete?
         find_post
        @post.destroy                    
      else
        params[:ids].each do |id|
          post = Post.find(id)
         post.destroy
        end
      end
      flash[:notice] = 'Пост успешно удален.'
      format.html { redirect_to(admin_posts_url) }
      format.xml  { head :ok }    
    end
  end

end
