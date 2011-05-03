# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :get_current_user_session, :get_current_user

  private
    def redirect_back_or_default(default)
       redirect_to(params[:return_to] || default)
       params[:return_to] = nil
    end

    def get_current_user_session
      return @user_session if defined?(@user_session)
      @user_session = UserSession.find
    end

    def get_current_user
      @current_user = @user_session && @user_session.record
    end

    def require_admin
      unless @current_user && @current_user.admin?
        flash[:notice] = 'Вы должны авторизироваться что бы получить доступ к данному разделу сайта'
        redirect_to "#{login_url}?return_to=#{request.path}"
      end
    end

    def render_404
      render :template => '/shared/404', :layout => false, :status => 404
    end

end
