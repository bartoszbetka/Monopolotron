class UsersController < ApplicationController
  layout 'unpublic', :except => [:new, :create]
  before_action :confirm_logged_in, :except => [:new, :create]
  before_action :privilege, :only => [:index, :special_delete, :special_destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new
    render layout: "public"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User created.'
      redirect_to(:controller=> 'public', :action => 'index')
    else
      render("new")
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:notice]= 'User updated.'
      redirect_to(:action => 'show')
    else
      render('edit')
    end
  end

  def delete
    @user = User.find(session[:user_id])
  end

  def destroy
    user = User.find(session[:user_id]).destroy
    session[:user_id] = nil
    session[:email] = nil
    flash[:notice] = "User deleted."
    redirect_to(:controller => 'public', :action => 'index')
  end

  def special_delete
    @suser = User.find(params[:id])
  end

  def special_destroy
    suser = User.find(params[:id]).destroy
    flash[:notice] = "User deleted."
    redirect_to(:action => 'index')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :email_confirmation, :password_digest, :password_digest_confirmation, :terms_of_service, :accept_age)
  end

end
