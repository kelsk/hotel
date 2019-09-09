require_relative 'calendar'
require_relative 'reservation_manager'

module Hotel
  
  class Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :id, :room, :dates, :discount
    
    def initialize(start_date, end_date, room, discount: 0)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @id = create_id
      @dates = get_all_dates
      @discount = discount
    end
    
    def create_id
      "#{@start_date.year % 100}#{@start_date.month}#{@start_date.day}#{rand(9999)}"
    end
    
    def get_all_dates
      (@start_date...@end_date).to_a
    end
    
    def calculate_total_cost
      rate = @discount == 0 ? @room.rate : @room.rate * @discount
      rate * @dates.length
    end
    
  end

end