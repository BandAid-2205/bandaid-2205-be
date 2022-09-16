class VenuePoro
    attr_reader :name, :rating, :price, :location
    def initialize(data)
        @name = data[:name]
        @rating = data[:rating]
        @price = data[:price]
        @location = data[:location]
    end 

end 