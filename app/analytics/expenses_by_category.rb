module Analytics
	class ExpensesByCategory
		def initialize(expense_group)
			@expense_group = expense_group
		end

		def group_by_category
			expenses_by_category = {}
			@expense_group.expenses.each do |expense|
				category = expense.category
				value = expense.value
				expenses_by_category[category] ||= 0
				expenses_by_category[category] += value
			end
			expenses_by_category
		end
	end
end