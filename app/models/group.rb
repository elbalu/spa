class Group
  include Mongoid::Document
  include Mongoid::Timestamps

require 'json'

  index({ guid: 1 }, { unique: true, background: true })
  field :uid, type: String
  field :name, type: String
  field :image, :type => String  
  field :default_location_lat, :type => String
  field :default_location_lng, :type => String
  attr_accessible :guid, :uid, :name, :image, :default_location_lat, :default_location_lng

  validates_presence_of :name, :uid, :guid

  def self.create_a_group(user, group)
    create! do |group|
      user.provider = auth['provider']   
      user.token = auth['credentials']['token']      
      user.uid = auth['uid']
      if auth['info']
         #store_friends(user, auth)
         store_latandlng(user, map)
         store_personalInfo(user, auth)
      end
    end
  end

  def self.store_personalInfo(user, auth)
    if auth['info'])
     user.name = auth['info']['name'] || ""
     user.email = auth['info']['email'] || ""
     user.first_name = auth['info']['first_name'] || ""
     user.last_name = auth['info']['last_name'] || ""
     user.name = user.first_name + user.last_name
     user.image = auth['info']['image'] || ""
     user.default_home_location = auth['info']['location'] || ""
   end
  end


  def self.store_latandlng(user, map)
    if map != nil        
      map_hash = JSON.parse(map)
      user.home_lat, user.default_lat = map_hash["home_lat"] || nil
      user.home_lng, user.default_lng = map_hash["home_lng"] || nil
      user.work_lat = map_hash["work_lat"] || nil
      user.work_lng = map_hash["work_lng"] || nil
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

  def self.check_and_validate_new_user(newUser)
   if User.find(newUser.fbid).length >0
     return false
   else
     return true
   end    
 end


end