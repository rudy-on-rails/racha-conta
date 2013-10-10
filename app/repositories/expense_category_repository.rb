module Repositories
	class ExpenseCategoryRepository
		def initialize
			@base_categories = ExpenseType.all.map(&:name)
		end

		def categories_for(user)
			expenses_categories = user.expenses.map(&:category)
			expenses_categories.delete_if{|c| c.blank?}
			@base_categories.concat(expenses_categories).uniq
		end
	end
end