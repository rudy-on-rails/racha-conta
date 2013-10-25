module Api
	class AccountsController < ApiController
		include ActionView::Helpers::NumberHelper
		require_dependency 'expense_totals_categorized_by_month'

		def history_categorized
			@account = Account.find(params[:id])
			year = params[:year].to_i
			validate_user_can_access_account!
			totals_by_category = Analytics::ExpenseTotalsCategorizedByMonth.new(@account).categorize_expenses_by_month(year)
			render :json => fix_formatting(totals_by_category)
		end

		private
		def fix_formatting(data)
			json = {}
			(1..12).each do |month|
				json[month] ||= {}
				per_month_data = data[month]
				if per_month_data
					json[month]["total"] = per_month_data.total
					json[month]["by_category"] = per_month_data.categorized_data
				else
					json[month]["total"] = 0
				end
			end
			json
		end
	end
end