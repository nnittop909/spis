class FilenameParser

	attr_reader :filename
	def initialize(args={})
		@filename = args[:filename]
	end

	def parse!
    filename_array = @filename.split("-")
    if filename_array.count >= 3
      post_array = [filename_array.second, filename_array.third]
      array = filename_with_r(post_array)
    else
      post_array = [filename_array.first, filename_array.second]
      array = filename_with_r(post_array)
    end
    array.join("-")
  end

  def filename_with_r(post_array)
    if @filename.include?("R")
      ["R#{post_array[0].gsub(/[^0-9,.]/, "")}", post_array[1].gsub(/[^0-9,.]/, "")]
    else
      [post_array[0], post_array[1]]
    end
  end
end