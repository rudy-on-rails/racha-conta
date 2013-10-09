class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from InsufficientPermissionError do |error|
  	flash[:error] = error.message
		redirect_to root_path
  end
end
