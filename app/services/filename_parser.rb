class FilenameParser

	attr_reader :filename, :documentable
	def initialize(args={})
    @filename = args[:filename]
    @documentable = args[:documentable]
	end

	def parse!
    if filename_array.count >= 3
      array = post_array << filename_array[2]
    else
      array = post_array
    end
    array.join("-")
  end

  def post_array #remove letters
    array = [filename_array[0], filename_array[1]].join("-").split("-")
    [array[0].gsub(/[^0-9,.]/, ""), second_value(array)]
  end

  def filename_array #remove "PO"
    @filename.split("-").to_a.map{|a| a.include?("PO") ? nil : [a]}.compact
  end

  def second_value(array)
    if @filename.include?("R")
      "#{array[1].gsub(/[^0-9,.]/, "")}R"
    else
      array[1].gsub(/[^0-9,.]/, "")
    end
  end
end