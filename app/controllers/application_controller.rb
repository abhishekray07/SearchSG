class ApplicationController < ActionController::Base
  protect_from_forgery

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '220.255.1.30'
    else
      request.remote_ip
    end
  end
  
end
