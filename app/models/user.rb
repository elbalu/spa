class User
  include Mongoid::Document
  include Mongoid::Timestamps
#require 'PersonalInfo'
require 'Post'
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
  # validates_presence_of :encrypted_password
  
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
  field :name, :type => String
  field :price, :type => String
  validates_presence_of :name
  attr_accessible :name, :profilePic 

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