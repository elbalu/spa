class SessionsController < ApplicationController
respond_to :json
  def new
    redirect_to '/auth/facebook'
  end

  def myfriends
    
  end

  def create
    auth = request.env["omniauth.auth"]
    
    #secret = request.env["omniauth.credentials.secret"] # omniauth['credentials']['secret'] rescue nil
    #logger.info("https://graph.facebook.com/me/friends?access_token=#{auth['token']}")
    logger.info("1111 type = #{auth.to_json}")
      
    @user = User.where(:provider => auth['provider'],
               :uid => auth['uid']).first || User.create_with_omniauth(auth, params[:map])
 #   me = User.store_friends(user,auth)

    #logger.info("ANAND friends locaton  = #{location.try(:name)}")
  
    #logger.info("ANAND  friends = #{friends[100].inspect}")
    #me.friends.each do |facebook_friend|
      # if facebook_friend.name == "BaluLoganathan"
       # logger.info("ANAND friend Balu work = #{me.friends.work}")
      # end
       #logger.info("ANAND  friends = #{me.friends.location}")   

       #logger.info("ANAND  friends = #{me.methods}")
       #User.client(auth['credentials']['token'])
#       logger.info("ANAND  friends = #{.methods}")
       #work = FbGraph::Posts.new()
       #work = FbGraph::Work.search('PayPal')#,:access_token => auth['credentials']['token'])

       #logger.info("ANAND friends work is  = #{work.inspect}")

     #  break
     #end 
     #logger.info("ANAND posts= #{myposts.to_json}")
    #print "friends ID ===========" 
      
    session[:user_id] = @user.id

    # @after_sign_in_url = '/'
    # redirect_to @after_sign_in_url
    if @user.email.blank?
      redirect_to edit_user_path(@user), :alert => "Please enter your email address."
    else
      logger.info("signed in #{@user.id}")
      #respond_with user
      #redirect_to root_url, :notice => 'Signed in!'
      #redirect_to root_url(@user => params[user])
      #redirect_to '/#{user.id}'
     # redirect_to :controller=>"home", :action=>"index", :id => @user.id
     #redirect_to url_for "#users/show", :id=&gt;@user.id
     # redirect_to url_for :controller => 'users', :action => 'show'                # => 'proto://host.com/posts/recent'
     #redirect_to users_path, :action=>'show', :anchor => '/', :id =>@user.id
     #redirect_to url_for(:controller=>'users',:action=>:index)+"#order"
     #redirect_to :controller => 'users', :action => 'show', :id => @user.id  #users/id     
##########temp##############
     #redirect_to home_path(:id => @user.id)     
     #render :controller=>'home', :action => 'show', :id=>@user.id  #users/id
#####WORKING###########
    render :template => 'users/show', :id=>@user.id  #users/id
#####WORKING###########
      #redirect_to :controller => 'home', :action => 'index', :id=>@user.id, :method => :post#:user => {:name => input[1], :password => input [2] },
      #:stylesheet => 'scaffold',
      #:method => :get)

    end

  end

  def destroy
    print "ddddddddddddddddddd"
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
