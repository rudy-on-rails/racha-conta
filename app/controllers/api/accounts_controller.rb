module Api
	class AccountsController < ApiController
		include ActionView::Helpers::NumberHelper
		require_dependency 'expense_totals_categorized_by_month'
		require_dependency 'highcharts_builder'

		def history_categorized
			@account = Account.find(params[:id])
			year = params[:year].to_i
			validate_user_can_access_account!
			totals_by_category = Analytics::ExpenseTotalsCategorizedByMonth.new(@account).categorize_expenses_by_month(year)
			render :json => Builders::HighchartsBuilder.build_history_data(totals_by_category)
		end
	end
end