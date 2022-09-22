class CurrentStageFinder

	attr_reader :stageable
	def initialize(args={})
		@stageable = args[:stageable]
		@stage = @stageable.current_stage
	end

	def current
		stagings = []
		@stageable.stagings.each do |s|
			if s.stage.alias_name == @stage
				stagings << s
			end
		end
		stagings.uniq.first
	end

	def date_approved
		if current.nil?
			"Date not set."
		else
			if @stage == "approved"
				if current.date.present?
					current.date.strftime("%B %e, %Y")
				else
					"Date not set"
				end
			end
		end
	end

	def date_approved_or_enacted
		if current.nil?
			"Date not set."
		else
			if @stage == "approved" || @stage == "approved_on_third_reading"
				if current.date.present?
					current.date.strftime("%B %e, %Y")
				else
					"Date not set"
				end
			else
				if current.effectivity_date.present?
					current.effectivity_date.strftime("%B %e, %Y")
				else
					"Date not set"
				end
			end
		end
	end

	def date_enacted
		if current.nil?
			"Date not set."
		else
			if @stage == ("vetoed" || "approved_on_third_reading")
				if current.effectivity_date.present?
					current.effectivity_date.strftime("%B %e, %Y")
				else
					"Date not set"
				end
			end
		end
	end

	def date_adopted
		if current.nil?
			"Date not set."
		else
			if @stage == ("vetoed" || "approved_on_third_reading")
				if current.effectivity_date.present?
					current.effectivity_date.strftime("%B %e, %Y")
				else
					"Date not set"
				end
			end
		end
	end
end