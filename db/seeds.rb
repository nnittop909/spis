office = Office.find_or_create_by(
	name:         "Office of the Sanguniang Panlalawigan Secretary",
	abbreviation: "SP-SEC"
)

office.users.admin.create!(
	first_name:            "Admin", 
	last_name:             "User",
	username:              "admin",
	email:                 "admin@sis.com",
	password:              "11111111",
	password_confirmation: "11111111"
)

office.users.developer.create!(
	first_name:            "Developer", 
	last_name:             "User",
	username:              "devop",
	email:                 "devop@sis.com",
	password:              "11111111",
	password_confirmation: "11111111"
)

Stage.find_or_create_by(name: "First Reading", phase: 0, alias_name: "first_reading")
Stage.find_or_create_by(name: "Second Reading", phase: 1, alias_name: "second_reading")
Stage.find_or_create_by(name: "Disapproved on Third Reading", phase: 2, alias_name: "disapproved_on_third_reading")
Stage.find_or_create_by(name: "For Deliberation", phase: 2, alias_name: "for_deliberation")
Stage.find_or_create_by(name: "Approved on Third Reading", phase: 2, alias_name: "approved_on_third_reading")
Stage.find_or_create_by(name: "Vetoed by the LCE", phase: 3, alias_name: "vetoed")
Stage.find_or_create_by(name: "Approved by the LCE", phase: 3, alias_name: "approved")
Stage.find_or_create_by(name: "Ammended", phase: 4, alias_name: "ammended")

Category.find_or_create_by(name: "Appropriation")
Category.find_or_create_by(name: "General")
Category.find_or_create_by(name: "Re-alignment")

Position.find_or_create_by(name: "Vice-Governor")
Position.find_or_create_by(name: "First-Board Member - District 1")
Position.find_or_create_by(name: "Second-Board Member - District 1")
Position.find_or_create_by(name: "Third-Board Member - District 1")
Position.find_or_create_by(name: "Fourth-Board Member - District 1")
Position.find_or_create_by(name: "First-Board Member - District 2")
Position.find_or_create_by(name: "Second-Board Member - District 2")
Position.find_or_create_by(name: "Third-Board Member - District 2")
Position.find_or_create_by(name: "Fourth-Board Member - District 2")
Position.find_or_create_by(name: "LIGA President")
Position.find_or_create_by(name: "PCL President")
Position.find_or_create_by(name: "SK President")
Position.find_or_create_by(name: "Committee")

cse1 = CivilServiceEligibility.find_or_create_by(name: "None")
cse2 = CivilServiceEligibility.find_or_create_by(name: "Professional")
cse3 = CivilServiceEligibility.find_or_create_by(name: "Sub-Professional")

ea1 = EducationalAttainment.find_or_create_by(name: "Bachelor's Degree")
ea2 = EducationalAttainment.find_or_create_by(name: "Master's Degree")
ea3 = EducationalAttainment.find_or_create_by(name: "Doctorate")
ea4 = EducationalAttainment.find_or_create_by(name: "N/A")

pp1 = PoliticalParty.find_or_create_by(name: "LP")
pp2 = PoliticalParty.find_or_create_by(name: "IND")
pp3 = PoliticalParty.find_or_create_by(name: "PDPLBN")
pp4 = PoliticalParty.find_or_create_by(name: "KBL")
pp5 = PoliticalParty.find_or_create_by(name: "AKSYON")
pp6 = PoliticalParty.find_or_create_by(name: "NACIONALISTA")

# Member.find_or_create_by!(
# 	first_name: "Alberto Jr", last_name: "Binlang", 
# 	district_id: d1.id, political_party_id: pp2.id, position_id: p1.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by!(
# 	first_name: "Ceasario", last_name: "Cabbigat", 
# 	district_id: d1.id, political_party_id: pp4.id, position_id: p2.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Jordan", last_name: "Gullitiw", 
# 	district_id: d1.id, political_party_id: pp2.id, position_id: p3.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Joselito", last_name: "Guyguyon", 
# 	district_id: d1.id, political_party_id: pp1.id, position_id: p4.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Orlando", last_name: "Addug", 
# 	district_id: d2.id, political_party_id: pp2.id, position_id: p1.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Peter", last_name: "Bunnag", 
# 	district_id: d2.id, political_party_id: pp2.id, position_id: p2.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Perfecta", last_name: "Dulnuan", 
# 	district_id: d2.id, political_party_id: pp2.id, position_id: p3.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

# Member.find_or_create_by(
# 	first_name: "Jojo", last_name: "Odan", 
# 	district_id: d2.id, political_party_id: pp1.id, position_id: p4.id,
# 	civil_service_eligibility_id: cse2.id, educational_attainment_id: ea4.id,
# 	appointment_status: "elective"
# )

puts "Seeds Loaded!"