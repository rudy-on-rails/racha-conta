module Analytics
	class ExpenseTotalsCategorizedByMonth
		def	initialize(account)
			@account = account
		end

		def categorize_expenses_by_month(year)
			expense_totals = {}
			@account.expenses_of(year).each do |expense|
				expense_totals[expense.created_at.month] ||= ExpenseTotalsByCategory.new
				expense_totals[expense.created_at.month].add_expense_value(expense.category, expense.value)
			end
			expense_totals
		end

		class ExpenseTotalsByCategory
			def initialize
				@expense_totals_by_month = {}
			end

			def add_expense_value(category, value)
				@expense_totals_by_month[category] ||= 0
				@expense_totals_by_month[category] += value
			end

			def total
				total = 0
				@expense_totals_by_month.each do |category, value|
					total += value
				end
				total
			end

			def by_category(category)
				@expense_totals_by_month[category]
			end
		end
	end
end