class Admin::RolesController < DashboardController
  before_filter :find_role, :only => [:show, :edit, :update]

  private
  def find_role
    @role = Role.find(params[:id])
  end

  public
  def index
    @filter = ActiverecordFilter.new(Role, params)
    @roles = Role.search(params)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @roles }
    end
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    respond_to do |format|
      if @role.save
        flash[:notice] = 'Роль успешно сохранена.'
        format.html { redirect_to edit_admin_role_path(@role) }
        format.xml  { render :xml => @role, :status => :created,
                    :location => [:admin, @role] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Роль успешно сохранена.'
        format.html { redirect_to edit_admin_role_path(@role) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    respond_to do |format|
      if request.delete?
        find_role
        @role.destroy
      else
        params[:ids].each do |id|
          @role = Role.find(id)
          @role.destroy
        end
      end
      flash[:notice] = 'Роль успешно удалена.'
      format.html { redirect_to(admin_roles_url) }
      format.xml  { head :ok }
    end
  end
end
