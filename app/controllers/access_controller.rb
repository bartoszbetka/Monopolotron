class AccessController < ApplicationController

  layout 'unpublic'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
  end

  def special
  end

  def login
    # login form
  end

  def attempt_login
    if params[:email].present? && params[:password_digest].present?
      found_user = User.where(:email => params[:email]).first
      if  found_user.password_digest == params[:password_digest]
        authorized_user = found_user
      end
      if authorized_user && authorized_user.privilege.present?
        session[:user_id] = authorized_user.id
        session[:name] = authorized_user.name
        flash[:notice] = "You are now logged in."
        redirect_to(:action => 'special')
      elsif authorized_user
        session[:user_id] = authorized_user.id
        session[:name] = authorized_user.name
        flash[:notice] = "You are now logged in."
        redirect_to(:action => 'index')
      else
        flash[:notice] = "Invalid username/password combination."
        redirect_to(:controller => 'public', :action => 'index')
      end
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:controller => 'public', :action => 'index')
    end
  end

  def logout
    session[:user_id] = nil
    session[:email] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => 'public', :action => 'index')
  end

end
