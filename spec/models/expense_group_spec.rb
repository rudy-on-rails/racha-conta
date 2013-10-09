require 'spec_helper'

describe ExpenseGroup do
  it {should belong_to :account}
  it {should have_many :expenses}
end
