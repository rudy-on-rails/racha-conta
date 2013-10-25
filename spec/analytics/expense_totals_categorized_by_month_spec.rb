require 'spec_helper'

describe Analytics::ExpenseTotalsCategorizedByMonth do
	let(:account){double("Account")}
	let(:expense_one){double("Expense")}
  let(:expense_two){double("Expense")}
  let(:expense_three){double("Expense")}

	before(:each) do
		expense_one.stub(:value => 5000)
		expense_one.stub(:category => "1")
		expense_one.stub(:created_at => Date.new(2013, 10, 01))
		expense_two.stub(:value => 2500)
		expense_two.stub(:category => "2")
		expense_two.stub(:created_at => Date.new(2013, 10, 01))
		expense_three.stub(:value => 2500)
		expense_three.stub(:category => "3")
		expense_three.stub(:created_at => Date.new(2013, 10, 01))
		account.stub(:expenses_of).and_return([expense_one, expense_two, expense_three])
	end
	
	describe "#categorize_expenses_by_month" do
		it "should sum expense values and group by month and category" do
			result = described_class.new(account).categorize_expenses_by_month(2013)
			result[10].total.should eq(10000)
			result[10].by_category("1").should eq(5000)
			result[10].by_category("2").should eq(2500)
			result[10].by_category("3").should eq(2500)
		end
	end
end
