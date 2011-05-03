class CommentsController < BaseController
  def create
    @post = Post.find(params[:post_id])
    @page = Page.from_model(@post)
    @comment = @post.comments.build(params[:comment])
    @comment.session_captcha = session[:captcha_text]
    @comment.status_id = 3
    @comment.validate_captcha = true
    if @comment.save
      flash[:notice] = "Комментарий успшено сохранен. После модерации он будет добавлен на сайт."
      redirect_to "#{post_path(@post)}#comments"
    else
      @post = Post.full.find(params[:post_id])
      render :template => '/posts/show'
    end
  end
end
