class NumberParser
	attr_reader :number

	def initialize(args={})
		@number = args[:number]
	end

	def parse!
		array = @number.split("-")
    processed = array.map{|a| a == array[1] ? second_num_part : a}
    processed.map{|a| a == array[0] ? number.split("-").first.to_i : a}.join
	end

	def second_num_part
    target_chars = @number.split("-").second
    char_size = target_chars.size
    case char_size
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