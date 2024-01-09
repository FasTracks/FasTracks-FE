module FastracksBeService
  class Playlist
    attr_reader :id, :name, :href, :tracks

    def initialize(data)
      @id = data[:id]
      @name = data[:name]
      @href = data[:href]
      @url = data[:external_urls][:spotify]
      @image = data[:images][:url]
      @total = data[:tracks][:total]
      # @tracks = data[:tracks][:items]
    end
  end
end
