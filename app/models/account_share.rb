class AccountShare < ActiveRecord::Base
  attr_accessible :account, :email
  belongs_to :account
  validates_presence_of :email
  before_save :generate_token

  private
  def generate_token
  	self.token = SecureRandom.urlsafe_base64
  end
end
