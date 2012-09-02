class FacebookController < ApplicationController
  def setup
    request.env['omniauth.strategy'].options[:scope] ='user_location,friends_location,user_work_history,friends_work_history'
    render :text => "Setup complete.", :status => 404
  end
end