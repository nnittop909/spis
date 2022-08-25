class MemberProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :first_name, :last_name, :middle_name, :name_suffix, 
								:birthdate, :address, :contact_number, :educational_attainment_id,
								:civil_status, :civil_service_eligibility_id,
								:other_info, :tin_number, :gsis_number

	validates :first_name, :last_name, :middle_name, presence: true

	def initialize(attr={})
		if !attr["id"].nil?
			@member = Member.find(attr["id"])
			self.first_name                   = attr[:first_name].nil? ? @member.first_name : attr[:first_name]
			self.middle_name                  = attr[:middle_name].nil? ? @member.middle_name : attr[:middle_name]
			self.last_name                    = attr[:last_name].nil? ? @member.last_name : attr[:last_name]
			self.name_suffix                  = attr[:name_suffix].nil? ? @member.name_suffix : attr[:name_suffix]
			self.birthdate                    = attr[:birthdate].nil? ? @member.birthdate : attr[:birthdate]
			self.address                      = attr[:address].nil? ? @member.address : attr[:address]
			self.contact_number               = attr[:contact_number].nil? ? @member.contact_number : attr[:contact_number]
			self.civil_status                 = attr[:civil_status].nil? ? @member.civil_status : attr[:civil_status]
			self.other_info                   = attr[:other_info].nil? ? @member.other_info : attr[:other_info]
			self.tin_number                   = attr[:tin_number].nil? ? @member.tin_number : attr[:tin_number]
			self.gsis_number                  = attr[:gsis_number].nil? ? @member.gsis_number : attr[:gsis_number]
			self.educational_attainment_id    = attr[:educational_attainment_id].nil? ? @member.educational_attainment_id : attr[:educational_attainment_id]
			self.civil_service_eligibility_id = attr[:civil_service_eligibility_id].nil? ? @member.civil_service_eligibility_id : attr[:civil_service_eligibility_id]
    else
      super(attr)
    end
  end

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				create_member
			end
		end
	end

	def update!
		if valid?
			ActiveRecord::Base.transaction do
				update_member
			end
		end
	end

	private

	def create_member
		Member.create!(
			first_name:                   first_name,
			middle_name:                  middle_name,
			last_name:                    last_name,
			last_name:                    name_suffix,
			birthdate:                    birthdate,
			address:                      address,
			contact_number:               contact_number,
			educational_attainment_id:    educational_attainment_id,
			civil_status:                 civil_status,
			civil_service_eligibility_id: civil_service_eligibility_id,
			other_info:                   other_info,
			tin_number:                   tin_number,
			gsis_number:                  gsis_number
		)
	end

	def update_member
		@member.update!(
			first_name:                   first_name,
			middle_name:                  middle_name,
			last_name:                    last_name,
			name_suffix:                  name_suffix,
			birthdate:                    birthdate,
			address:                      address,
			contact_number:               contact_number,
			educational_attainment_id:    educational_attainment_id,
			civil_status:                 civil_status,
			civil_service_eligibility_id: civil_service_eligibility_id,
			other_info:                   other_info,
			tin_number:                   tin_number,
			gsis_number:                  gsis_number
		)
	end
end