class ApiController < ApplicationController
	include AccountValidations
	
	rescue_from InsufficientPermissionError do |error|
  	render status: :forbidden, json: {}
  end
end