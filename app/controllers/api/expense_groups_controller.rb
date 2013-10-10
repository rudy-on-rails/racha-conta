module Api
	class ExpenseGroupsController < ApiController
		include ActionView::Helpers::NumberHelper
		require_dependency 'expenses_by_category'

		def total_by_category
			group = ExpenseGroup.find(params[:id])
			@account = group.account
			validate_user_can_access_account!
			totals_by_category = Analytics::ExpensesByCategory.new(group).group_by_category
			render :json => fix_formatting(totals_by_category)
		end

		private
		def fix_formatting(data)
			new_data = []
			data.each do |category, total|
				category = "Sem categoria" if category.nil?
				new_data << [category, total.to_f]
			end
			new_data
		end
	end
end