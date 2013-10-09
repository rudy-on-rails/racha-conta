require 'spec_helper'

describe User do
  it {should have_many :accounts_created}
	it {should have_and_belong_to_many :shared_accounts}  
end