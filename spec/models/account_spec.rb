require 'spec_helper'

describe Account do
  it {should belong_to :creator}
  it {should have_and_belong_to_many :shared_with}  
  it {should have_many :expense_groups}  
  it {should have_many :account_shares}
end