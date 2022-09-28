class NumberParser
	attr_reader :number

	def initialize(args={})
		@number = args[:number]
	end

	def parse!
		array = @number.split("-")
    first_number = array[0].gsub(/[^0-9,.]/, "")
    second_number = second_num_part(array)
    [first_number, second_number].join("-")
	end

	def second_num_part(array)
    target_chars = array[1].to_i.to_s
    case target_chars.size
    when 1
      "000#{target_chars}"
    when 2
      "00#{target_chars}"
    when 3
      "0#{target_chars}"
    else
      target_chars
    end
  end
end