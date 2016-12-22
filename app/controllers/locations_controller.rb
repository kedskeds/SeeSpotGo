class LocationsController < ApplicationController
  def new
    @location = Location.new
    render :json => { :location_form => (render_to_string("locations/_form", layout: false)) }
  end

  def create
    @location = Location.create(location_params)
    @locations = current_user.locations || []
    render :json => { :space_form => (render_to_string("spaces/_form", layout: false, locals: {location: @location, space: Space.new})),
                      :location_selector => (render_to_string("home/_location_selector", layout: false)),
                      :location_id => @location.id }
  end

  def show
    @location = Location.find_by_id(params[:id])
    @user = User.find_by_id(@location.user_id)

    # @location_data = {
    #   latitude: @location.latitude,
    #   longitude: @location.longitude,
    #   infobox: (render_to_string("search/_infobox", layout: false, locals: {location: @location}))
    # }
    #   # @results = @locations.map do |location|
    #   #   { latitude: location.latitude,
    #   #     longitude: location.longitude,
    #   #     infobox: (render_to_string("search/_infobox", layout: false, locals: {location: location})) }
    #   # end
    #   render :json => @location_data
  end

  def update
  end

  def location_params
    params.require(:location).permit(:street_address, :city, :state, :zip).merge(user_id: current_user.id)
  end
end
