class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :authorized_sce,     only: [:new_sce, :create_sce]
  before_action :authorized_ase,     only: [:new_ase, :create_ase]

  def index
    @users = User.order(:name).paginate(page: params[:page])
    render :template => 'users/index'
  end

  def show
    @user = User.find(params[:id])
    render :template => 'users/show'
  end

#  def new
#    @user = User.new
#  end

  def new_sce
    @title = 'Create user'
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @user = User.new
  end

  def new_ase
    @title = 'Create user'
    @agent = Agent.find(params[:agent_id])
    @user = User.new
  end

#  def create
#    type = params[:user][:type]
#    if(type == SCUser.name)
#      @user = SCUser.new(sc_user_params)
#    elsif(type == AUser.name)
#      @user = AUser.new(a_user_params)
#    else
#      render 'new'
#    end
#    if @user.save
#      sign_in @user
#      flash[:success] = "Welcome to POSEIDON!"
#      redirect_to @user
#    else
#      render 'new'
#    end
#  end

  def create_sce
    @user = SCUser.new(sc_user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to POSEIDON!"
      redirect_to @user
    else
      @shipping_company = ShippingCompany.find(params[:user][:shipping_company_id])
      render 'new_sce'
    end
  end

  def create_ase
    @user = AUser.new(a_user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to POSEIDON!"
      redirect_to @user
    else
      @agent = Agent.find(params[:user][:agent_id])
      render 'new_ase'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def sc_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :shipping_company_id)
    end

    def a_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :agent_id)
    end
    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  end
