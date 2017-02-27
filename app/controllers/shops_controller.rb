class ShopsController < ApplicationController
  layout :layout
  #layout 'unpublic', :except => :search
  before_action :confirm_logged_in, :except => [:show, :search]
  before_action :privilege, :except => [:show, :new, :create, :search, :index, :fav, :favourite, :fav_destroy]
  #before_action :check, :only => :search
  def index
    @shops = Shop.visible
    @hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow shop.shopname
      marker.picture({
        :url    => "/images/shopping.png",
        :width  => 33,
        :height => 44
      })
      marker.title   shop.shopname
    end
  end

  def search
    if params[:search].present? && params[:distan].present?
      # unless session[:user_id]
      # render layout: "public"
      #  end

      # render(:layout =>'public') and return
      searches = Geocoder.coordinates(search1)
      @sea = searches[0]
      @sae = searches[1]
      @hasha = Gmaps4rails.build_markers(searches) do |searches, marker|
        marker.lat  @sea
        marker.lng  @sae
        marker.infowindow "Your location"
        marker.picture({
          :url    => "/images/real-estate.png",
          :width  => 33,
          :height => 44
        })
        marker.title   "Your location"
      end
      @shops = Shop.visible.near(search1, params[:distan], :units => :km)
      @hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
        marker.lat shop.latitude
        marker.lng shop.longitude
        marker.infowindow shop.shopname
        marker.picture({
          :url    => "/images/shopping.png",
          :width  => 33,
          :height => 44
        })
        marker.title   shop.shopname
      end
    else

      #render(:layout =>'public') and return
      #  render layout: "public"
      @shops = Shop.visible
      @hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
        marker.lat shop.latitude
        marker.lng shop.longitude
        marker.infowindow shop.shopname
        marker.picture({
          :url    => "/images/shopping.png",
          :width  => 33,
          :height => 44
        })
        marker.title   shop.shopname
      end
    end
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      flash[:notice] = 'Shop created and awaiting acceptation.'
      redirect_to(:action => 'index')
    else
      render("new")
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update_attributes(shop_params)
      flash[:notice] = "Shop updated successfully."
      redirect_to(:action => 'manage', :id => @shop.id)
    else
      render('edit')
    end
  end

  def delete
    @shop = Shop.find(params[:id])
  end

  def destroy
    shop = Shop.find(params[:id]).destroy
    flash[:notice] = "Shop '#{shop.shopname}' deleted successfully."
    redirect_to(:action => 'manage')
  end

  def manage
    @shops = Shop.all
  end

  def wait_accept
    @shops = Shop.invisible
  end

  def accept
    @shop = Shop.find(params[:id])
    @shop.update_attributes(:visible => true)
    if @shop.visible.present?
      flash[:notice] = "Shop updated successfully."
      redirect_to(:action => 'wait_accept', :id => @shop.id)
    end
  end

  def favourite
    shop = Shop.find(params[:id])
    you = User.find(session[:user_id])
    #if @shop.update_attributes(:user_id => session[:user_id])
    if shop.users << you
      flash[:notice] = "You have added '#{shop.shopname}' to favourites."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Something went wrong."
      redirect_to(:action => 'index')
    end
  end

  def fav
    user = User.find(session[:user_id])
    if @favshops = user.shops
      return true
    else
      flash[:notice] = "You do not have any favourite shops."
      redirect_to(:action => 'index')
    end
  end

  def fav_destroy
    shop = Shop.find(params[:id])
    user = shop.users.find(session[:user_id])
    if user
      shop.users.destroy(user)
      flash[:notice] = "Shop '#{shop.shopname}' deleted successfully."
      redirect_to(:action => 'fav')
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:shopname, :address, :topen, :tclose)
  end

  def search1
    #  render layout: "public"
    [params[:search], 'Wrocław', 'Polska'].compact.join(', ')
  end

  def check
    unless session[:user_id]
      render layout: "public"
    end
  end

  def layout
    case action_name
    when "search"
      unless session[:user_id]
        "public"
      else
        "unpublic"
      end
    else
      'unpublic'
    end
  end
  #def convers
  # ["latitude", "longtitude"].compact.join(@searches)
  #end
end
