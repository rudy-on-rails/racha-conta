# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_share do
    email "MyString"
    account_id 1
  end
end
