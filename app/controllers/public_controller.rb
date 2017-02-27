class PublicController < ApplicationController

  layout 'public'
  before_action :check

  def index
  end

  def contact
  end

  private
  def check
    if session[:user_id].present?
      flash[:notice] = 'You are now logged in.'
      redirect_to(:controller => 'access', :action => 'index')
    end
  end
end
