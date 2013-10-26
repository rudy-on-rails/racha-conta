module Builders
	class HighchartsBuilder
		def self.build_history_data(monthly_categorized_data)
			highcharts_data = {}
			highcharts_data["categories"] = []
			highcharts_data["series"] = []
			total_serie = {
					type: 'spline',
	      name: 'Total',
	      data: []
			}
			(1..12).each do |month|
				month_name = I18n.t("date.abbr_month_names")[month]
				highcharts_data["categories"] << month_name
				month_total = monthly_categorized_data[month].total if monthly_categorized_data[month]
				month_total = 0 if month_total.nil?
				total_serie[:data] << month_total.to_f
			end
			highcharts_data["series"] << total_serie

			monthly_categorized_data["categories"].each do |category|
				category_serie = {
					type: 'column',
	        data: []	
				}
				category_serie[:name] = category
				(1..12).each do |month|
					value = monthly_categorized_data[month].by_category(category) if monthly_categorized_data[month]
					value = 0 if value.nil?
					category_serie[:data] << value.to_f
				end
				highcharts_data["series"] << category_serie
			end
			
			highcharts_data
		end
	end
end