module Hotel
  
  class Room
    
    TOTAL_ROOMS = 20
    BASE_RATE = 200
    
    attr_reader :id, :rate
    
    def initialize(id)
      @id = id
      @rate = BASE_RATE
    end
    
    def self.load_all
      rooms = []
      TOTAL_ROOMS.times do |i| 
        rooms << new(i+1)
      end
      return rooms
    end
    
  end
  
end