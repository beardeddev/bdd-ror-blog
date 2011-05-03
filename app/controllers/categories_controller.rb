class CategoriesController < BaseController
  def show
    category_id = params[:id].to_i
    @posts = Post.categorised(category_id).paginate(:page => params[:page])

    @category = Category.active.find(category_id)
    if @category
      @page = Page.from_model(@category)
      @page.title = "Посты в категории #{@category.title}"
    end

    render :template => 'posts/index'
  end
end
