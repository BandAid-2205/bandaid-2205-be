class VenuePoro
    attr_reader :name, :rating, :price, :location, :id

    def initialize(data)
        @name = data[:name]
        @rating = data[:rating]
        @price = data[:price] 
        @location = address(data[:location])
        @id = data[:id]
    end 

    def address(location)
        "#{location[:address1]} #{location[:address2]} #{location[:city]}, #{location[:state]} #{location[:zip_code]}"
    end
end 