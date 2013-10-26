module Analytics
	class ExpenseTotalsCategorizedByMonth
		def	initialize(account)
			@account = account
			@categories = []
		end

		def categorize_expenses_by_month(year)
			expense_totals = {}
			@account.expenses_of(year).each do |expense|
				if expense.category.blank?
					@categories << "Sem Categoria" 
				else
					@categories << expense.category
				end
				expense_totals[expense.created_at.month] ||= ExpenseTotalsByCategory.new
				expense_totals[expense.created_at.month].add_expense_value(expense.category, expense.value)
			end
			expense_totals["categories"] = @categories.uniq
			expense_totals
		end

		class ExpenseTotalsByCategory
			attr_reader :categorized_data
			def initialize
				@categorized_data = {}
			end

			def add_expense_value(category, value)
				category = "Sem Categoria" if category.nil?
				@categorized_data[category] ||= 0
				@categorized_data[category] += value
			end

			def total
				total = 0
				@categorized_data.each do |category, value|
					total += value
				end
				total
			end

			def by_category(category)
				@categorized_data[category]
			end

			def categories
				@categorized_data.keys
			end
		end
	end
end