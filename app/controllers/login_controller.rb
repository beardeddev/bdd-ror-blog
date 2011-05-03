class LoginController < BaseController
  def new
    @page.title = "Вход на сайт"
    if request.post?
      @user_session = UserSession.new(:login => params[:login], :password => params[:password])
      if @user_session.save
        flash[:notice] = "Добро пожаловать #{params[:login]}"
        redirect_back_or_default root_path
      else
        flash[:error] = "Неверный логин и/или пароль"
        render :action => :new
      end
    end
  end

  def destroy
    @user_session.destroy
    redirect_back_or_default root_path
  end

end
