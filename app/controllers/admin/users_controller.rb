class Admin::UsersController < DashboardController
  before_filter :find_user, :only => [:show, :edit, :update]
  before_filter :find_roles, :only => [ :new, :create, :edit, :update]
  after_filter  :link_roles, :only => [:create, :update]
  
  private
  def find_user      
    @user = User.find(params[:id])
  end

  def find_roles
    @roles = Role.all
  end

  def link_roles
    @user.role_ids = params[:roles] || []
  end
  
  public
  def index
    @filter = ActiverecordFilter.new(User, params)    
    @users = User.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save      
        flash[:notice] = 'Пользователь успешно сохранен.'
        format.html { redirect_to edit_admin_user_path(@user) }
        format.xml  { render :xml => @user, :status => :created,
                    :location => [:admin, @user] }      
      else      
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }      
      end
    end
  end
  
  def edit
  end
  
  def update    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Пользователь успешно сохранен.'      
        format.html { redirect_to edit_admin_user_path(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity } 
      end
    end
  end
  
  def show
  end
  
  def destroy
    respond_to do |format|
      if request.delete?
        find_user
        @user.destroy                    
      else
        params[:ids].each do |id|
          user = User.find(id)
          user.destroy
        end
      end
      flash[:notice] = 'Пользователь успешно удален.'
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }    
    end
  end
end
