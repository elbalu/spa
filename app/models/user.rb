class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
 
#require 'PersonalInfo'
require 'Post'
require 'json'
#require 'Setting'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable


  # field :name, type: String
  # field :price, type: String
  


  # ## Database authenticatable
  # field :email,              :type => String, :default => ""
  # field :encrypted_password, :type => String, :default => ""

  # validates_presence_of :email
   #validates_presence_of :encrypted_password
  
  # ## Recoverable
  # field :reset_password_token,   :type => String
  # field :reset_password_sent_at, :type => Time

  # ## Rememberable
  # field :remember_created_at, :type => Time

  # ## Trackable
  # field :sign_in_count,      :type => Integer, :default => 0
  # field :current_sign_in_at, :type => Time
  # field :last_sign_in_at,    :type => Time
  # field :current_sign_in_ip, :type => String
  # field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes

 # def find()
  #User.find_by(name:"eggs")
    #User.all.first
    #User.find("5001771610bda9f6c9ca8a32")
  #end
  # store_in collection: "User", database: "test"
  index({ name: 1 }, { unique: true, background: true })
  index({ uid: 1 }, { unique: true, background: true })
  field :provider, type: String
  field :uid, :type=>Moped::BSON::ObjectId
  field :token, type: String
  #field :secret, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, :type=> String
  field :name, :type => String
  field :image, :type => String
  field :work_group_name, :type => String
  field :work_location_name, :type => String
  field :friend_id, :type => String
  field :home_lat, :type => String
  field :home_lng, :type => String
  field :default_lat, :type => String
  field :default_lng, :type => String
  field :work_lng,:type => String
  field :work_lat,:type => String
  field :default_home_location, :type =>String
  field :created_at, :type=>DateTime
  field :location, :type=>Hash

  attr_accessible :provider, :uid, :name, :email, :name, :image, :first_name, :last_name, :token,:friend_id,
                  :home_lat, :home_lng, :default_lat, :default_lng, :default_home_location, :home_location_name,
                  :work_lng, :work_lat, :work_location_name, :work_group_name,
                  :id

  validates_presence_of :name, :uid
  module UserUpdates
    UPDATE_LOCATION =0
    UPDATE_DEFAULT_WORK_LOCATION = 1
    UPDATE_DEFAULT_HOME_LOCATION = 2
    UPDATE_PERSONAL_INFO = 3
  end
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })


  def self.check_user_exists(newUser)
   if User.find(newUser.uid).length >0
     return 
   else
     return true
   end    
 end

  def self.set_update_user(id, update_obj, update_type)
    logger.info("ANAND update")    

    if update_type == UserUpdates::UPDATE_LOCATION then
       
    end  
    test_mode = 1
    if test_mode ==1 then 
      update_obj = Hash.new 
      update_obj['lng'] = '89.22'
      update_obj['lat'] = '0.22'
      local_json = update_obj.to_json
      #logger.info("ANAND constructed local json = #{local_json}")
      #@anand_loaded = User.find(id)
      
      #logger.info("ANAND loaded user = #{@anand_loaded.inspect}")
      #id = BSON::ObjectId(params[:id])
      

      #@update_user = User.where(:_id=> Moped::BSON::ObjectId(id))#.find_and_modify(local_json, new: true)
      logger.info(" Record searching")
      
      user_collection = User.collection
      find_updated(update_obj)
      
      # @update_user = user_collection.findAndModify({
      #         query:{"_id"=>id} },
      #         update:{$set: }, 
      #         new: true
      #         })
      # logger.info(" Record found and  updated #{@update_user.inspect}")
      #redirect_to profile_path(@user)
    else
      find_updated(obj_for_update)
      #respond_with User.find_and_modi(params[:id], params[:user])
      #set_update_user(params[:user])
      #respond_with User.where(_id: id).find_and_modify(user, new: true)
    end
    # rescue
    #   logger.info("No Record found to update")
    #   #respond_with nil  
  end  



  # def self.find_updated(obj_for_update)
  #   #update all objects in the hash 
  #   hash_obj = JSON.parse(obj_for_update)
  #   if hash_obj.has_key?("location") then  
  #     if hash_obj.include_key?("work") return UserUpdates::UPDATE_DEFAULT_WORK_LOCATION
  #      end 
  #   end    
  # end
  




  def self.create_with_omniauth(auth, map)
    create! do |user|
      user.provider = auth['provider']   
      user.token = auth['credentials']['token']      
      user.uid = auth['uid']
      
      if auth['info']
         #store_friends(user, auth)         
         store_personalInfo(user, auth)         
         store_location_and_group(user, map)
      end
    end
  end





  def self.store_personalInfo(user, auth)
    if auth['info']
     user.name = auth['info']['name'] || ""
     user.email = auth['info']['email'] || ""
     user.first_name = auth['info']['first_name'] || ""
     user.last_name = auth['info']['last_name'] || ""
     user.name = user.first_name + user.last_name
     user.image = auth['info']['image'] || ""
     user.default_home_location = auth['info']['location'] || ""
   end
  end


  def self.store_location_and_group(user, map)
    if map != nil
      map_hash = JSON.parse(map)
      user.location = Hash.new
      user.location["home_lat"], user.default_lat = map_hash["home_lat"] || nil
      user.location["home_lng"], user.default_lng = map_hash["home_lng"] || nil
      user.location["home_location_name"] ||= user.default_home_location = map_hash["home_location_name"] || nil
      
      user.location["work_group_name"] = map_hash["work_group_name"] || nil
      user.location["work_location_name"] = map_hash["work_location_name"] || nil
      user.location["work_lat"] = map_hash["work_lat"] || nil
      user.location["work_lng"] = map_hash["work_lng"] || nil      
    end
  end

def self.store_friends(user,auth)
  facebook_user = FbGraph::User.fetch(user.uid, :access_token => user.token)
  friends = facebook_user.fetch.friends
  i = 0
  friends.each do |friend|
    i+=1
    location = friend.fetch.location
    user.default_home_location = location.try(:name)
    work = friend.fetch.work
    if work.any?  then 
      #logger.info("ANAND work before parsing  = #{work.inspect}") 
      work_to_json = work.to_json
      #logger.info("ANAND work 11 before parsing  = #{work_to_json.inspect}")
      parsed_json  = JSON.parse(work_to_json)
      #logger.info("ANAND work 11 before parsing  = #{parsed_json.inspect}")
      #logger.info("ANAND work 11 before parsing  = #{parsed_json[0]['employer'].inspect}")
      if parsed_json.nil? then logger.info("ANAND grop 11 =empty")
      elsif parsed_json.any?  then 
        parsed_json = parsed_json[0]
        if parsed_json['employer']['identifier'].nil? then user.group_name = nil 
        else 
          user.group_name = parsed_json['employer']['raw_attributes']['name']
          user.friend_id = parsed_json['employer']['identifier']
          break
        end           
      end
    end

    if i>5 then
       break
    end
  end

    # logger.info ("Anand in fetch friends")
    # print "ddddddddddddddddddddeeeeeeeeeeeefffffffffffffff"
    # facebook_user = FbGraph::User.me user.token
    # #logger.info("ANAND  type = #{friend_id.inspect}")
    # print "friends ID ===========" 
    # #print friend_id.identifier
    # return facebook_user #facebook_user.friends,  facebook_user.posts
    
    # facebook = User.where(:provider => "facebook").first
    # fb_user = ::FbGraph::User.fetch facebook.uid, :access_token => facebook.token
    # fb_albums = fb_user.albums

    #friends = Array.new

 #   friends = {auth['token']}
 #   user['friends'] = 
end

#def self.getDummyJSON()

# $userObj = array(
#    'User' =>
#        array('uid' => 123442,
#       'personalInfo' => array('firstName' => 'Schrodinger', 'email' => 'balu.com'),
#       'friends' => array('UID' =>123),
#       'groups' => array('gid' =>334444),
#       'posts' => array(' ' =>123, 'locations'=>array(0=>array('lat' =>'80.9900000', 'lng' =>'18.00000'), 1=> array('lat' =>'99.9900000', 'lng' =>'19.00000'))),
#       'setting' => array('lat' =>'33.33', 'lng' =>'18'),
#       'risk'=> array('rating'=>1.5)
#       )
#       );
# $updateReq = array('uid' => 123442,
#       'setting' => array('lat' =>'99.9900000', 'lng' =>'18.00000')
#       );

 #   a = PersonalInfo.new("Shodinger", "hmm","Shodinger hmm", "var@method.work" ) #:firstname,:lastname, :name, :email
    # post_location = {"lat"=>"99.000","lng"=>"12.993"}
    #(locations, comments, title, description, likes, shares)

    # "posts": [{
    #         "type": "lend",
    #         "name": "Balu Loganathan",
    #         "product": "html5",
    #         "price": "USD 5",
    #         "duration": "week",
    #         "profilePic": "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/195691_100000504585832_6817704_q.jpg"


    #b = Post.new(post_location,"you suck", "yay baby","welcome to fitocracy",Array.new(123, 333, 56767,355,4566), Array.new( 56767,355) )
     
    #:locations,:comments, :title, :description, :likes, :shares
  #   c = Setting.new(11,22.00, 4577344666)
  #   :lat,:lng, :mobile
  #   @user = Array.new
  #   d= Hash.new("uid" =>"123")
  #   @user << d
  #   @user << a
  #   logger.info("11 type = #{@user.to_json}")
  #   @user << b
  #   @user << c
    
  #   p @user.to_json

  #   logger.info("type = #{@user.to_json}")
  
  # end

end