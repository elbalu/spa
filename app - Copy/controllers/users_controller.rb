class UsersController < ApplicationController
#  before_filter :authenticate_user!
respond_to :json  

  def index
    @users = User.all
  end

  def show
    respond_with User.find_by(name:"Anand Sengottuvelu")
  end

  # def show

  #   @user = User.find
  #   #@user =User.getDummyJSON()
   
  #   print "ANAND in show", @user#type
  #   logger.info("##########################")
  #   #logger.info(User.find())
  #   logger.info("My #{@user}")
  # end

  def create
    check_and_validate_new_user(params[:user])
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
     end 
  end

  def update
    respond_with User.update(params[:id], params[:user])
  end
 
  def destroy
    respond_with User.destroy(params[:id])
  end


#class
end	 