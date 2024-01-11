class FastracksBeServiceFacade
  def self.submit_playlist(info)
    response = FastracksBeService.submit_playlist(info)
    JSON.parse(response.body, symbolize_names: true)
  end
end