class CurrentStageFinder

	attr_reader :stageable
	def initialize(args={})
		@stageable = args[:stageable]
		@stage = @stageable.current_stage
	end

	def staging
		stagings = []
		@stageable.stagings.each do |s|
			if s.stage.approved?
				stagings << s
			end
		end
		stagings.uniq.first
	end

	def date_approved
		if staging.nil?
			"Please update stage"
		else
			if @stageable.class.name == "Resolution"
				if @stage == "approved"
					if staging.date.present?
						staging.date.strftime("%B %e, %Y")
					else
						""
					end
				end
			else
				if @stage == "approved" || @stage == "approved_on_third_reading" || @stage == "vetoed"
					if staging.date.present?
						staging.date.strftime("%B %e, %Y")
					else
						""
					end
				end
			end
		end
	end

	def date_enacted #Ordinance
		if staging.nil?
			"Please update stage."
		else
			if @stage == "vetoed" || @stage == "approved_on_third_reading"
				if staging.effectivity_date.present?
					staging.effectivity_date.strftime("%B %e, %Y")
				else
					""
				end
			end
		end
	end

	def date_adopted #Resolution
		if staging.nil?
			"Date not set."
		else
			if @stage == "approved_on_second_reading"
				if staging.effectivity_date.present?
					staging.effectivity_date.strftime("%B %e, %Y")
				else
					staging.date.strftime("%B %e, %Y")
				end
			end
		end
	end

	def status
		staging.stage.name
	end
end