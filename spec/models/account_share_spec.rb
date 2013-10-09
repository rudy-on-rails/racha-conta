require 'spec_helper'

describe AccountShare do
  it {should belong_to :account}
  it {should validate_presence_of :email}

  let(:account){FactoryGirl.build(:account)}
  context "after-save callback" do
    it "should generate a base64-based token" do
    	account_share = AccountShare.new(account: account, email: "test@test.com")
    	account_share.token.should be_blank
    	account_share.save
    	account_share.token.should_not be_blank
    end
  end
end
