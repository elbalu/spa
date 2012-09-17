
class UsersController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :correct_user?
  respond_to :json  

  def index
    logger.info("###############################")
    #@users = User.all
    logger.info("anand i user index #{User.all}")
    respond_with User.all
  end

  def show
    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    respond_with User.find(params[:id])
  end

  def edit
    respond_with User.find(params[:id])
  end

  # def show

  #   @user = User.find
  #   #@user =User.getDummyJSON()
   
  #   print "ANAND in show", @user#type
  #   logger.info("##########################")
  #   #logger.info(User.find())
  #   logger.info("My #{@user}")
  # end

  # def create
  #   logger.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%")
  #   check_and_validate_new_user(params[:user])
  #   @user = User.new(params[:user])
  #   if @user.save
  #     self.current_user = @user
  #    end 
  # end

  def update
    #respond_with User.update(params[:id], params[:user])
    logger.info("$$$$$$$$$$$$ inside User::UPDATE")
    @id = params[:id]
    @user = params[:user]
    #@update_type = params[:update_type]
    respond_with User.update_user(@id, @user)
  end
 
  def destroy
    respond_with User.destroy(params[:id])
  end
  def client (token)
    #@client ||= FBGraph::Client.new(:client_id => '114709451898747',
    #                               :secret_id => '7c87164749a02552e3d204142e3af16b' , 
    @client ||= FBGraph::Client.new(:client_id => '367021960037106',
                                   :secret_id => 'e85b494eee9517d7eeb3fd3ce3cfd51b',
                                   :token => token)
  end


#class
end	 