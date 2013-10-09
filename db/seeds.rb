# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.find_by_email("rudyseidinger@gmail.com").nil?
	user = User.new(
		:name => "Rudy Wagner Seidinger",
		:password => "123321",
		:password_confirmation => "123321",
		:email => "rudyseidinger@gmail.com"
	)
	user.save!
end

ExpenseType.create(:name => "Supermercado")
ExpenseType.create(:name => "Viagens")
ExpenseType.create(:name => "Contas")
ExpenseType.create(:name => "Nights")