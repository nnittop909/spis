class Chunkify

	attr_reader :records

	def initialize(args={})
		@records = args[:records].pluck(:id)
	end

	def chunk!
    @records.find_each(batch_size: @chunk_size) {|chunk| yield chunk }
  end

  def chunk_size
    files_count = @records.count
    case files_count
    when (1..100)
      1
    when (101..200)
      2
    when (201..300)
      3
    when (301..400)
      4
    when (401..500)
      5
    when (501..600)
      6
    when (601..700)
      7
    when (701..800)
      8
    when (801..900)
      9
    when (901..1000)
      10
    end
  end
end