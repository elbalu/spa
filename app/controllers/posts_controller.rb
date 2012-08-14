class PostsController < ApplicationController
#  before_filter :authenticate_user!

     respond_to :json

  def index
      #@post = Post.applyFilter()
    respond_with Post.all
  end
 
  def show
     if params.has_key?(:uid) || params.has_key?(:pid)
      @post = Post.show_filter(params[:uid], params[:pid])

      print "ANAND in post show", @post#type
      logger.info("##########################")
      respond_with @post
    end
  end
 
  #def create
  #	logger.info ("My user #{params[:post]}")

  def create
    respond_with Post.create(params[:post])
  end
  
    # if params.has_key?(:post)
    #   @post = Post.setter_for_post(params[:post])
    #   respond_with Post.map_and_create(@post)
    # end 
  #end
 
  def update
    respond_with Post.update(params[:id], params[:post])
  end
 
  def destroy
    respond_with Post.destroy(params[:id])
  end
end