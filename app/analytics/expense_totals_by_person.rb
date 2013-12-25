module Analytics
	class ExpenseTotalsByPerson
		def initialize(account)
			@totals_by_person = []			
			expenses = account.opened_expenses

			expenses.each do |expense|
				total = @totals_by_person.select{|t| t.user == expense.spent_by}.first
				total ||= TotalSpentByPerson.new(expense.spent_by)
				total.add_value_spent(expense.value)
				@totals_by_person << total if not @totals_by_person.include?(total)
			end

			@totals_by_person
		end

		def sumarize_total_spent_by_person
			@totals_by_person
		end

		def ammount_to_share_per_person
			diff = 0
			@totals_by_person.each do |totals_by_person|
				if diff == 0
					diff = totals_by_person.total_value_spent
				else
					diff -= totals_by_person.total_value_spent
				end
			end

			if @totals_by_person.count > 0
				(diff.abs.to_f / @totals_by_person.count)
			else
				0.00
			end
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