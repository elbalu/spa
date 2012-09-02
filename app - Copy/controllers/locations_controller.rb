class LocationsController < ApplicationController
	
     respond_to :json

  def index
      #@post = Location.applyFilter()
    respond_with Location.all
  end
 
end
