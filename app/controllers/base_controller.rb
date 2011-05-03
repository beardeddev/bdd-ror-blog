class BaseController < ApplicationController
  before_filter :get_page, :get_categories, :get_archive,  :get_page, :get_pages, :get_menu

  private
    def get_page
      path = CGI::unescape(request.path)
      @page = Page.active.find_by_url(path)
      unless @page
        @page = Page.new
      end
    end

    def get_archive
      @archive = Post.archive
    end

    def get_categories
      @categories = Category.counted
    end

    def get_pages
      @pages = Page.active.all
    end

    def get_menu
      @item = Menu.active.all
    end

end