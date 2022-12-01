office = Office.find_or_create_by(
	name:         "Office of the Sanguniang Panlalawigan Secretary",
	abbreviation: "SPSEC"
)

office.sp_terms.find_or_create_by(
	ordinal_number: 18,
	start_of_term: ("2019-07-01").to_date,
	end_of_term: ("2022-06-30").to_date
)

office.sp_terms.find_or_create_by(
	ordinal_number: 19,
	start_of_term: ("2022-07-01").to_date,
	end_of_term: ("2025-06-30").to_date
)

Stage.find_or_create_by(name: "First Reading", phase: 0, alias_name: "first_reading")
Stage.find_or_create_by(name: "Second Reading", phase: 1, alias_name: "second_reading")
Stage.find_or_create_by(name: "Disapproved on Third Reading", phase: 2, alias_name: "disapproved_on_third_reading")
Stage.find_or_create_by(name: "For Deliberation", phase: 2, alias_name: "for_deliberation")
Stage.find_or_create_by(name: "Approved on Third Reading", phase: 2, alias_name: "approved_on_third_reading")
Stage.find_or_create_by(name: "Vetoed by the LCE", phase: 3, alias_name: "vetoed")
Stage.find_or_create_by(name: "Approved by the LCE", phase: 3, alias_name: "approved")
Stage.find_or_create_by(name: "Ammended", phase: 4, alias_name: "ammended")
Stage.find_or_create_by(name: "Approved on Second Reading", phase: 1, alias_name: "approved_on_second_reading")
Stage.find_or_create_by(name: "Active File/File Away", phase: 1, alias_name: "active_file")

Category.find_or_create_by(name: "Appropriation")
Category.find_or_create_by(name: "General")
Category.find_or_create_by(name: "Re-alignment")

Position.find_or_create_by(name: "Vice-Governor", alias_name: "vgov")
Position.find_or_create_by(name: "First-Board Member - District 1", alias_name: "bmd1")
Position.find_or_create_by(name: "Second-Board Member - District 1", alias_name: "bmd1")
Position.find_or_create_by(name: "Third-Board Member - District 1", alias_name: "bmd1")
Position.find_or_create_by(name: "Fourth-Board Member - District 1", alias_name: "bmd1")
Position.find_or_create_by(name: "First-Board Member - District 2", alias_name: "bmd2")
Position.find_or_create_by(name: "Second-Board Member - District 2", alias_name: "bmd2")
Position.find_or_create_by(name: "Third-Board Member - District 2", alias_name: "bmd2")
Position.find_or_create_by(name: "Fourth-Board Member - District 2", alias_name: "bmd2")
Position.find_or_create_by(name: "PCL President", alias_name: "pcl")
Position.find_or_create_by(name: "LIGA President", alias_name: "liga")
Position.find_or_create_by(name: "SK President", alias_name: "sk")

cse1 = CivilServiceEligibility.find_or_create_by(name: "None")
cse2 = CivilServiceEligibility.find_or_create_by(name: "Professional")
cse3 = CivilServiceEligibility.find_or_create_by(name: "Sub-Professional")

ea1 = EducationalAttainment.find_or_create_by(name: "Bachelor's Degree")
ea2 = EducationalAttainment.find_or_create_by(name: "Master's Degree")
ea3 = EducationalAttainment.find_or_create_by(name: "Doctorate")
ea4 = EducationalAttainment.find_or_create_by(name: "N/A")

pp1 = PoliticalParty.find_or_create_by(name: "LIBERAL PARTY", code: "LP")
pp2 = PoliticalParty.find_or_create_by(name: "INDEPENDENT", code: "IND")
pp3 = PoliticalParty.find_or_create_by(name: "PDP-LABAN", code: "PDPLBN")
pp4 = PoliticalParty.find_or_create_by(name: "KILUSANG BAGONG LIPUNAN", code: "KBL")
pp5 = PoliticalParty.find_or_create_by(name: "AKSYON", code: "AKSYON")
pp6 = PoliticalParty.find_or_create_by(name: "NACIONALISTA", code: "NP")
pp7 = PoliticalParty.find_or_create_by(name: "LAKAS-CMD", code: "LKSCMD")
pp7 = PoliticalParty.find_or_create_by(name: "PARTIDO FEDERAL", code: "PFP")

puts "Seeds Loaded!"