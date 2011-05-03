class PagesController < BaseController
  def show
    if @page.new_record?
      render_404
    end
  end
end
