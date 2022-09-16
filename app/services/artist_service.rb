class ArtistService 
  def self.search_artist(name)
    response = conn.get("/2.0/?method=artist.getinfo&artist=#{name}&format=json")

    response_check(response)
  end

  private 
    def self.conn 
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday| 
        faraday.params['api_key'] = ENV['last_fm_key']
      end
    end

    def self.response_check(response)
      JSON.parse(response.body, symbolize_names: true) if response.status == 200 
    end
end