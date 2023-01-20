class NumberParser
	attr_reader :number

	def initialize(args={})
		@number = args[:number]
	end

  def parse_for_importing_ordinance!
    array = @number.split("-")
    first_number = array[0].gsub(/[^0-9,.]/, "")
    second_number = set_second_number_for_ordinance(array)
    if array.count >= 3
      [first_number, second_number, array[2]].join("-")
    else
      [first_number, second_number].join("-")
    end
  end

  def parse_for_importing_resolution!
    array = @number.split("-")
    first_number = array[0].gsub(/[^0-9,.]/, "")
    second_number = set_second_number_for_resolution(array)
    if array.count >= 3
      [first_number, second_number, array[2]].join("-")
    else
      [first_number, second_number].join("-")
    end
  end

	def parse!
		array = @number.split("-")
    first_number = array[0].gsub(/[^0-9,.]/, "")
    second_number = second_num_part(array)
    if array.count >= 3
      [first_number, second_number, array[2]].join("-")
    else
      [first_number, second_number].join("-")
    end
	end

  def set_second_number_for_ordinance(array)
    if array[0].include?("R")
      "#{array[1].gsub(/[^0-9,.]/, "")}R"
    else
      array[1]
    end
  end

  def set_second_number_for_resolution(array)
    if array[1].to_i.to_s.size == 1
      "0#{array[1].to_i}"
    else
      array[1].to_i
    end
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