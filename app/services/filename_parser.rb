class FilenameParser

	attr_reader :filename
	def initialize(args={})
    @filename = args[:filename]
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
    [array[0].gsub(/[^0-9,.]/, ""), "#{array[1].gsub(/[^0-9,.]/, "")}R"]
  end

  def filename_array #remove "PO"
    @filename.split("-").to_a.map{|a| a.include?("PO") ? nil : [a]}.compact
  end
end