module Hotel
  
  class Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :room
    
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      @room = []
    end
    
    
  end
  
end