require_relative 'calendar'
require_relative 'reservation_manager'

module Hotel
  
  class Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :id, :room, :dates
    
    def initialize(start_date, end_date, room)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @id = create_id
      @dates = get_all_dates
    end
    
    def create_id
      "#{@start_date.year % 100}#{@start_date.month}#{@start_date.day}#{rand(9999)}"
    end
    
    def get_all_dates
      (@start_date...@end_date).to_a
    end
    
    def calculate_total_cost
      @room.rate * @dates.length
    end
    
  end
  
end