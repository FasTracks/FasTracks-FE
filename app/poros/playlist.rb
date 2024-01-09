class Playlist
  attr_reader :id, :name, :url, :tracks

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    # @href = data[:href]
    @url = data[:external_urls][:spotify]
    # @image = data[:images][:url]
    @total = data[:tracks][:total]
    @data = data
    # @tracks = data[:tracks][:items]
  end

  def list_of_songs_and_artist
    track_and_artist_hash = {}
    @data[:tracks][:items].each do |item|
      track_name = item[:track][:name]
      artist_names = item[:track][:artists].map { |artist| artist[:name] }.to_sentence
      track_and_artist_hash[track_name] = artist_names
    end
    track_and_artist_hash
  end

  # def playlist_name
  #   @name
  #   require 'pry'; binding.pry
  # end
  
  # def album_image
  #   @data
  # end
end