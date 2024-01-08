module FastracksBeService
  class Track
    attr_reader :id, :href, :album_name, :artist_name, :track_name

    def initialize(data)
      @id = data[:tracks][:items][:track][:id]
      @href = data[:tracks][:items][:track][:href]

      @album_name = data[:tracks][:items][:track][:album][:name]
      @artist_name = data[:tracks][:items][:track][:artists][:name]
      @track_name = data[:tracks][:items][:track][:name]
      # song name
      # album image
    end
  end
end
