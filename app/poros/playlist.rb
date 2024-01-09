class Playlist
  attr_reader :id, :name, :url, :total

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
    all_tracks_info = { tracks: []}
    @data[:tracks][:items].each do |item|
      track_name = item[:track][:name]
      artist_names = item[:track][:artists].map { |artist| artist[:name] }.to_sentence
      track_image = item[:track][:album][:images][2][:url]
      
      track_info_hash = { 
        name: track_name,
        artist: artist_names,
        image: track_image
      }
      all_tracks_info[:tracks] << track_info_hash
    end
    all_tracks_info
  end

  # def playlist_name
  #   @name
  #   require 'pry'; binding.pry
  # end
  
  # def album_image
  #   @data
  # end
end