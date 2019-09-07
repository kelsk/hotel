require_relative 'calendar'
require_relative 'reservation_manager'

module Hotel
  
  class Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :room, :dates
    
    def initialize(start_date, end_date, room)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @dates = get_all_dates
    end
    
    def get_all_dates
      (@start_date...@end_date).to_a
    end
    
    def calculate_total_cost
      @room.rate * @dates.length
    end
    
  end
  
end