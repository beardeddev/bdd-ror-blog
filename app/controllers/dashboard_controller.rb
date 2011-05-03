class DashboardController < ApplicationController 
  
  layout 'dashboard'

  before_filter :require_admin, :get_page

  private
  def get_page
    @page_info = Page.new
    controller_name = t("controllers.#{self.controller_name}")
    action_name = t("controllers.actions.#{self.action_name}")
    @page_info.title = "#{controller_name} :: #{action_name}"
  end
  
end