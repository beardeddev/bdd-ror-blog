class PostsController < BaseController
  def index
    @posts = Post.abbreviated.paginate(:page => params[:page])
  end

  def show
    @post = Post.full.find(params[:id])
    if @post
      @page = Page.from_model(@post)
      if(@current_user && (@post.user_id != @current_user.id))
        @post.update_attribute(:hits, @post.hits + 1)
      end
    end
    @comment = Comment.new
  end

  def archive
    month = params[:month].to_i
    year = params[:year].to_i

    @posts = Post.abbreviated.archived(month, year).paginate(:page => params[:page])

    @date = Russian.localize(Date.new(year, month, 1), :format => "%B %Y")
    @page.title = "Архив материалов #{@date}"
    @page.description = "Архив материалов #{@date}"
    @page.keywords = "Архив материалов #{@date}"
    render :action => 'index'
  end

  def rss
    @posts = Post.abbreviated
    render :layout => false
  end

  def sitemap
    @posts = Post.active
    @pages = Page.active
    render :layout => false
  end

end
