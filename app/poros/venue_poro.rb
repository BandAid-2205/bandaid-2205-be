class VenuePoro
    attr_reader :name, :rating, :phone, :price, :location, :id, :category

    def initialize(data)
        @name = data[:name]
        @rating = data[:rating]
        @phone = data[:phone]
        @price = data[:price] 
        @location = address(data[:location])
        @category = categories_list(data[:categories])
        @id = data[:id]
    end 

    def address(location)
        "#{location[:address1]} #{location[:address2]} #{location[:city]}, #{location[:state]} #{location[:zip_code]}"
    end

    def categories_list(categories)
        categories.map { |category| category[:title] }
    end 
end 