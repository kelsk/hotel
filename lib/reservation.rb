require_relative 'calendar'

module Hotel
  
  class Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :room_id, :dates
    
    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @room_id = get_a_room
      @dates = get_all_dates
    end
    
    def get_all_dates
      cal = Hotel::Calendar.new
      cal.get_date_range(@start_date, @end_date)
    end
    
    def get_a_room
      rooms = Hotel::ReservationManager.new.rooms
      @room_id = rooms.first.id
    end
    
  end
  
end