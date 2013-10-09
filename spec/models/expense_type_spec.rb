require 'spec_helper'

describe ExpenseType do
  it {should have_many :expenses}
end
