class CreateMunicipalOrdinance
	
	def create_ordinances
		resolutions = Resolution.search("DECLARING AS VALID AND OPERATIVE THE MUNICIPAL").all
		resolutions.each do |resolution|
			squeezed_title = resolution.title.gsub(/[^0-9A-Za-z]/, ' ').gsub("\n", " ").squeeze(' ')
			title_array = squeezed_title
							.gsub("MUNICIPAL ORDINANCE NO", "MUNICIPAL_ORDINANCE_NO")
							.gsub("APPROPRIATION ORDINANCE NO", "APPROPRIATION_ORDINANCE_NO")
							.gsub("SERIES OF", "SERIES_OF")
							.gsub("MUNICIPALITY OF", "MUNICIPALITY_OF")
							.gsub("SANGGUNIANG BAYAN NG", "SANGGUNIANG_BAYAN_NG")
							.gsub("MLGU OF", "MLGU_OF")
							.gsub("SUPPLEMENTAL BUDGET", "SUPPLEMENTAL_BUDGET")
							.split(" ")
			if resolution.municipal_ordinance.blank?
				if find_ordinance_number(title_array).present? && find_municipality(title_array).present?
					resolution.create_municipal_ordinance!(
						year_and_number: find_ordinance_number(title_array),
						year_series: set_series(title_array),
						keyword: find_keyword(title_array),
						municipality_id: find_municipality(title_array).id,
						date_approved: resolution.date_approved
					)
				end
			end
		end
	end

	def find_ordinance_number

		number_index = title_array.find_index("MUNICIPAL_ORDINANCE_NO") || title_array.find_index("APPROPRIATION_ORDINANCE_NO")
		series_index = title_array.find_index("SERIES") || title_array.find_index("SERIES_OF")

		if number_index.present?
			text1 = title_array[number_index + 1]
			text2 = title_array[number_index + 2]
			if series_index.present?
				year = title_array[series_index + 1]
				text_array = [year]
				[text1, text2].each do |txt|
					if has_number? txt
						text_array << txt
					end
				end
				text_array.join("-")
			else
				text_array = []
				[text1, text2].each do |txt|
					if has_number? txt
						text_array << txt
					end
				end
				text_array.join("-")
			end
		else
			nil
		end
	end

	def set_series(title_array)
		number = find_ordinance_number(title_array)
		number.split("-").first.to_i
	end

	def find_keyword(title_array)
		title_index = title_array.find_index("ENTITLED")
		supplemental_index = title_array.find_index("SUPPLEMENTAL_BUDGET")
		supplemental_budget_number = "#{title_array[supplemental_index + 1] title_array[supplemental_index + 2]}"
		annual_index = title_array.find_index("ANNUAL BUDGET")

		if title_index.present?
			beginning_title_index = keyword_index + 1
		else
			beginning_title_index = 0
		end
		ending_title_index = title_array.index title_array.last
		if supplemental_index.present?
			"#{set_series(title_array).to_s} SUPPLEMENTAL BUDGET #{supplemental_budget_number}"
		elsif annual_index.present?
			"#{set_series(title_array).to_s} ANNUAL BUDGET"
		else
			title_array[beginning_title_index..ending_title_index].join(" ")
		end
	end

	def find_municipality(title_array)
		Municipality.select{ |m| title_array.include?(m.name.upcase) ? m : nil }.compact_blank.last
	end

	def has_number? string
		string =~ /\d/ ? true : false
	end
end