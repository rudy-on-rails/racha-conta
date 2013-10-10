require 'spec_helper'

describe Repositories::ExpenseCategoryRepository do
	let!(:a_expense_type){FactoryGirl.create(:expense_type, name: "medical care")}
	let(:user){double("User")}
	let(:expense_category_repository){
		described_class.new
	}

	describe "#categories_for" do
		context "given the user has expenses with categories" do
			before(:each) do
				expense_one = double
				expense_two = double

				expense_one.stub(:category => "market")
				expense_two.stub(:category => "market")

				user.stub(:expenses => [expense_one, expense_two])
			end

			it "should merge base expense types with all users expense unique categories" do
				expense_category_repository.categories_for(user).should eq(["medical care", "market"])
			end
		end	

		context "given the user has expenses with not categorized" do
			before(:each) do
				expense_one = double
				expense_two = double

				expense_one.stub(:category => nil)
				expense_two.stub(:category => nil)

				user.stub(:expenses => [expense_one, expense_two])
			end
			it "should return just the base categories" do
				expense_category_repository.categories_for(user).should eq(["medical care"])
			end
		end
	end
end