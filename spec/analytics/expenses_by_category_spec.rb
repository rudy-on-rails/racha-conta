require 'spec_helper'

describe Analytics::ExpensesByCategory do
	let(:expense_group){double("ExpenseGroup")}
	
	describe "#group_by_category" do
		it "should sum expense values and group by category" do
		  expense_one = double(:expense, category: 'first_categpry', value: 100)
		  expense_two = double(:expense, category: 'first_categpry', value: 300)
		  expense_three = double(:expense, category: 'second_category', value: 100)

			expense_group.stub(:expenses => [expense_one, expense_two, expense_three])

			described_class.new(expense_group).group_by_category.should eq({
				'first_categpry' => 400,
				'second_category' => 100
			})
		end
	end
end
