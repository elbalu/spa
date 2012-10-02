class HomeController < ApplicationController
 respond_to :json
  def index
    @users = User.all
    logger.info("$$$$$$$$$$$$$$$$$$$$$$ in index with params = #{params[:id]}")
    #@user = User.find(params[:id])
    #@user = User.find(params[:id])
  end
  def show
    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    @user = User.find(params[:id])
  end
end
