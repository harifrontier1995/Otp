class ApplicationController < ActionController::Base
   # called before every action on controllers
  before_action :authorize_request, except: [:send_code, :create]
  attr_reader :current_user

  
  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
