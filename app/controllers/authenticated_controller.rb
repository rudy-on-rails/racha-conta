#encoding: utf-8
class AuthenticatedController < ApplicationController
	before_filter :authenticate_user!
	include AccountValidations
end