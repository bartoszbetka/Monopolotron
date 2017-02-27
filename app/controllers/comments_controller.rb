class CommentsController < ApplicationController
  layout 'unpublic'
  before_action :confirm_logged_in
  before_action :privilege, :only => [:all]
  before_action :check, :only => [:edit, :update, :delete, :destroy]
  before_action :update_average_rating, :only => [:index]

  def index
    @shop = Shop.find(params[:shop_id])
    @comments = @shop.comments
    @average_rating
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    #@shop = Shop.find(params[:id])
    #@user = User.find(session[:user_id])
    @comment = Comment.new()
    #@shops = Shop.visible
    #@comment_count = Comment.count + 1
  end

  def create
    @comme = Comment.new(comment_params)
    @comme.shop_id = params[:shop_id]
    if @comme.save
      flash[:notice] = 'Comment added.'
      #redirect_to(:action => 'index')
      redirect_to :back
    else
      redirect_to(:action => 'index', :shop_id => @comme.shop_id)
    end
  end

  def edit
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.find(params[:id])
    # @comment_count = Comment.count
  end

  def update
    @comment = Comment.find(params[:id])
    @shop = @comment.shop_id
    #@user = User.find(session[:user_id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "Comment updated successfully."
      redirect_to(:action => 'index', :shop_id => @shop)
    end
  end

  def delete
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    @shop = comment.shop_id
    flash[:notice] = "Comment deleted successfully."
    redirect_to(:action => 'index', :shop_id => @shop)
  end

  def all
    @comments = Comment.all
  end

  private

  def comment_params
    @user = User.find(session[:user_id])
    params.require(:comment).permit(:rate, :comments).merge(:user_id => @user.id)
  end

  def check
    user = User.find(session[:user_id])
    comment = Comment.find(params[:id])
    if user == comment.user_id
      return true
    elsif user.privilege.present?
      return true
    else
      flash[:notice] = "You can not edit this comment."
      redirect_to :back
    end
  end

  def update_average_rating
    @shop = Shop.find(params[:shop_id])
    @comments = @shop.comments
    @value = 0
    @comments.each do |comment|
      @value = @value + comment.rate
    end
    @total = @comments.size
    @average_rating = @value / @total.to_f
  end
end
