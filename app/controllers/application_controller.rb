class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'public', :action => 'index')
      return false
    else
      return true
    end
  end

  def privilege
    if @user = User.find(session[:user_id])
      if @user.privilege.present?
        return true
      else
        flash[:notice] = 'You can not access this page.'
        redirect_to(:controller => 'access', :action => 'index')
      end
    end
  end


end
