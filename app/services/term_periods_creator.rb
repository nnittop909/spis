class TermPeriodsCreator
	attr_accessor :code

	def initialize(args={})
		@code        = args[:code]
	end

	def start_of_term
		case @code
		when 3 
			("2001-07-01").to_date #2001
		when 4 
			("2013-07-01").to_date #2013
		when 8 
			("2007-07-01").to_date #2007
		when 9 
			("2004-07-01").to_date #2004
		when 10 
			("1998-07-01").to_date #1998
		when 11 
			("1995-07-01").to_date #1995
		when 12 
			("2010-07-01").to_date #2010
		when 13 
			("1992-07-01").to_date #1992
		when 14 
			("1989-07-01").to_date #1989
		when 15 
			("1986-07-01").to_date #1986
		when 16 
			("1983-07-01").to_date #1983
		when 17 
			("1980-07-01").to_date #1980
		when 19 
			("1977-07-01").to_date #1977
		when 20 
			("1974-07-01").to_date #1974
		when 21 
			("1971-07-01").to_date #1971
		when 22 
			("1968-07-01").to_date #1968
		when 23 
			("1965-07-01").to_date #1965
		when 24 
			("2016-07-01").to_date #2016
		when 25 
			("2019-07-01").to_date #2019
		when 27 
			("2022-07-01").to_date #2022
		else

		end
	end

	def end_of_term
		start_of_term + 3.years - 1.day
	end

end