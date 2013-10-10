require 'spec_helper'

describe Expense do
  it {should belong_to :expense_group}
  it {should belong_to :spent_by}  
end