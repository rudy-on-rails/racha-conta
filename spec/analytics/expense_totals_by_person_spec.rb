require 'spec_helper'

describe Analytics::ExpenseTotalsByPerson do
	let(:account){double("Account")}
	let(:expense_total_by_person){described_class.new(account)}

	describe "#ammount_to_share_per_person" do
		context "when account#opened_expenses is empty" do
			before(:each) do
				account.stub(:opened_expenses => [])
			end

		  it "returns empty array" do
		  	expense_total_by_person.ammount_to_share_per_person.should eq(0)
		  end
		end

		context "when account#opened_expenses returns expenses instances" do
			let(:john){double("User")}
			let(:mary){double("User")}
			let(:expense_one){double("Expense")}
			let(:expense_two){double("Expense")}

			before(:each) do
				expense_one.stub(:spent_by => john)
				expense_one.stub(:value => 1220)
				expense_two.stub(:spent_by => mary)
				expense_two.stub(:value => 3210)
				account.stub(:opened_expenses => [expense_one, expense_two])
			end

		  it "should return the difference of all expenses / number of persons" do
		  	ammount = expense_total_by_person.ammount_to_share_per_person
		  	ammount.should eq(995.00)
		  end
		end
	end

	describe "#sumarize_total_spent_by_person" do
		context "when account#opened_expenses is empty" do
			before(:each) do
				account.stub(:opened_expenses => [])
			end

		  it "returns empty array" do
		  	expense_total_by_person.sumarize_total_spent_by_person.should be_empty
		  end
		end

		context "when account#opened_expenses returns expenses instances" do
			let(:john){double("User")}
			let(:mary){double("User")}
			let(:expense_one){double("Expense")}
			let(:expense_two){double("Expense")}

			before(:each) do
				expense_one.stub(:spent_by => john)
				expense_one.stub(:value => 1220)
				expense_two.stub(:spent_by => mary)
				expense_two.stub(:value => 3210)
				account.stub(:opened_expenses => [expense_one, expense_two])
			end

		  it "should return an array with TotalSpentByPerson instances with sumarized values expent for each person" do
		  	totals = expense_total_by_person.sumarize_total_spent_by_person
		  	totals.count.should eq(2)

		  	totals.first.user.should eq(john)
		  	totals.first.total_value_spent.should eq(1220)

		  	totals.last.user.should eq(mary)
		  	totals.last.total_value_spent.should eq(3210)
		  end
		end
	end
end