module Analytics
	class ExpenseTotalsByPerson
		def initialize(account)
			@account = account
		end

		def sumarize_total_spent_by_person
			totals_by_person = []
			expenses = @account.opened_expenses

			expenses.each do |expense|
				total = totals_by_person.select{|t| t.user == expense.spent_by}.first
				total ||= TotalSpentByPerson.new(expense.spent_by)
				total.add_value_spent(expense.value)
				totals_by_person << total if not totals_by_person.include?(total)
			end

			totals_by_person
		end
	end

	class TotalSpentByPerson
		attr_reader :user, :total_value_spent

		def initialize(user)
			@user = user
			@total_value_spent = 0
		end

		def add_value_spent(value)
			@total_value_spent += value
		end
	end
end