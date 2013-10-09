# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    name "MyString"
    expense_type_id 1
    account_id 1
    value ""
  end
end
