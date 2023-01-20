ImageMeta = Struct.new(:image) do
  def width
  	image.blob.metadata.values.second
  end

  def height
  	image.blob.metadata.values.third
  end
end