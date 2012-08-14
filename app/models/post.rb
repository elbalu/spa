class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  require 'User'  
  require 'json'
#  before_filter :authenticate_user!
 

 #'posts' => Array.new(' ' =>123, 'locations'=>Array.new(0=>Array.new('lat' =>'80.9900000', 'lng' =>'18.00000'), 1=> Array.new('lat' =>'99.9900000', 'lng' =>'19.00000'))),
  #attr_accessor :locations,:comments, :title, :description, :likes, :shares
  # def initialize(locations, comments, title, description, likes, shares)
  #   @locations=locations
  #   @comments= comments
  #   @title= title
  #   @description= description 
  #   @likes= likes
  #   @shares= shares
  # end

# def self.threaded_with_field(story, field_name='votes')
#     comments = find(:all, :conditions => {:story_id => story.id}, :order => "path asc, #{field_name} desc")
#     results, map  = [], {}
#     comments.each do |comment|
#       if comment.parent_id.blank?
#         results << comment
#       else
#         comment.path =~ /:([\d|\w]+)$/
#         if parent = $1
#           map[parent] ||= []
#           map[parent] << comment
#         end
#       end
#     end
#     assemble(results, map)
#   end

#   # Used by Comment#threaded_with_field to assemble the results.
#   def self.assemble(results, map)
#     list = []
#     results.each do |result|
#       if map[result.id.to_s]
#         list << result
#         list += assemble(map[result.id.to_s], map)
#       else
#         list << result
#       end
#     end
#     list
#   end


  index({ uid: 1 }, { unique: true, background: true })
  index({ pid: 1 }, { unique: true, background: true })
  
  field :created_at, :type=>DateTime
  
  field :uid, :type=>Moped::BSON::ObjectId
  field :name, :type=>String
  field :type, :type=>String
  field :profilePic, :type=>String

  field :groupname, :type=>String
  
  validates_presence_of :uid
  attr_accessible :pid, :uid, :name, :type,:profilePic, :groupname

  def self.show_filter(uid, pid)

  post_collection = Post.collection
  
  #post_collection.find({"name"=>"Anand Sengottuvelu"})
      if pid.nil?
        @post = post_collection.find({"uid"=>uid}).limit(20)
        @user = User.find(uid)
        @post.username = @user.name
        @post.profilePic = @user.profilePic
          # time = Time.new
          # @post = Post.where (uid:uid, created_at.gt:time.now.utc, created_at.lt:(time.now.utc + 172800))
          # count = @post.count
          # print "count = ",count
        # else
        #   print "post is not more than 25"
        # end  
      else
        @post = post_collection.find({"_id"=>pid}).limit(20)
        @user = User.find(@post.uid)
        @post.username = @user.name
        @post.profilePic = @user.profilePic
      end  
  end

  def self.setter_for_post(json_post)
    @post = new Post
    
    post = JSON.parse json_post
    @post[:uid]= hashed_post["uid"]
  end 


end