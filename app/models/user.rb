class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
 # extend FriendlyId


  require 'Post'
  require 'json'
  require 'mongoid'

  #friendly_id :first_name

  field :home_loc, :type => Array
  field :work_loc, :type => Array

  index({ name: 1 }, { unique: true, background: true })
  index({ uid: 1 }, { unique: true, background: true })
  #index [[:home_loc, Mongo::GEO2D]] #, background: true)
  #index([[:work_loc, Mongo::GEO2D]], background: true)
  #index ([[:home_loc, Mongo::GEO2D]], background: true)
  #index ([[:work_loc, Mongo::GEO2D]],  background:true
  index({ work_loc: "2d" }, { min: -200, max: 200 }) 
  index({ home_loc: "2d" }, { min: -200, max: 200 }) 
  # index( [[:home_loc, Mongo::GEO2D]], background: true)
  # index( [[:work_loc, Mongo::GEO2D]], background: true)

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
  field :home_location_name, :type => String
  field :friend_id, :type => String
  field :default_home_location, :type =>String
  field :created_at, :type=>DateTime
  
  attr_accessible :provider, :uid, :name, :email, :name, :image, :first_name, :last_name, :token,:friend_id,
                  :default_home_location, :home_location_name,
                  :work_location_name, :work_group_name,
                  :id

  validates_presence_of :name, :uid
  module UserUpdates
    UPDATE_BOTH_LOCATION =0
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

  def self.update_user(id, update_obj)
    logger.info("ANAND UPDATE FOR #{id.inspect}")
    test_mode = 0
    user_hash = Hash.new
    unless update_obj.nil? then
      user_hash = JSON.parse(update_obj)
      return nil
    end  
    if test_mode == 1 then
      user_hash["location"] = User.create_dummy_location
      logger.info("ANAND UPDATING USER LOCATION #{user_hash.inspect}")
      return User.update_location(id, user_hash)
    else
      return User.update_location(id, user_hash)
    end
  end

  def self.update_location(id, hash_obj)
    logger.info("ANAND UPDATING USER LOCATION #{hash_obj.inspect}")

    #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/

    #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/
    
    #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/
    
    #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/

        #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/
    
    #FIXME PUT IT AS A NESTED ATTRUIBUTE http://stackoverflow.com/questions/8841400/mongoid-accepts-nested-attributes-for-saving-parent-when-child-is-invalidwell
    # http://stackoverflow.com/questions/10805449/mongoid-accepts-nested-attributes-for-not-saving
    #http://mongoid.org/en/mongoid/
    


    if !hash_obj.nil? && (hash_obj.has_key?("location") ? hash_obj["location"].has_key?("home_loc") : false)  then
      @home = seek(hash_obj, "location","home_loc")
      logger.info("ANAND update_location #{id.inspect} &&& home_loc #{@home.inspect}") 
    end  
    if !hash_obj.nil? && (hash_obj.has_key?("location") ? hash_obj["location"].has_key?("work_loc") : false)  then
      @work = seek(hash_obj, "location","work_loc")
      logger.info("ANAND update_location #{id.inspect} &&& work_loc #{@work.inspect}")
    end  
    unless @home.nil? && @work.nil? then
      return User.where(_id: id).update(home_loc: @home, work_loc:@work)      
    end     
  end

  def self.seek(hash_obj, *_keys_)
    last_level    = hash_obj
    sought_value  = nil
    _keys_.each_with_index do |_key_, _idx_|
      if last_level.is_a?(Hash) && last_level.has_key?(_key_)
        if _idx_ + 1 == _keys_.length
          sought_value = last_level[_key_]
        else                   
          last_level = last_level[_key_]
        end
      else 
        break
      end
    end
     sought_value
  end 

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
      if test_mode ==1 then
        map_hash["location"] = User.create_dummy_location
      end  
      user.home_loc << map_hash.has_key?("home_lat") || nil
      user.home_loc << map_hash.has_key?("home_lng") || nil
      user.home_location_name ||= user.default_home_location = map_hash.has_key?("home_location_name") || nil
      
      user.work_group_name = map_hash.has_key?("work_group_name") || nil
      user.work_location_name = map_hash.has_key?("work_location_name") || nil
      user.work_loc << map_hash.has_key?("work_lat") || nil
      user.work_loc << map_hash.has_key?("work_lng") || nil
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
  end

  def self.create_dummy_location()
      update_obj = Hash.new 
      home_loc = Array.new
      home_loc << 19.0 <<99.0
      work_loc = Array.new
      work_loc << 33.0 <<28.0
      update_obj['home_loc'] = home_loc
      update_obj['work_loc'] = work_loc
      #local_json = update_obj.to_json
      return update_obj
  end  


end