class HomeController < ApplicationController
 respond_to :json
  def index
    @users = User.all
    #@user = User.find(params[:id])
  end
  def show
    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    @user = User.find(params[:id])
  end
end
