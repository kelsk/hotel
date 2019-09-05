require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations
    
    def initialize
      @rooms = Hotel::Room.load_all
      @reservations = []
    end
    
    def create_reservation(start_date, end_date)
      @reservations << Hotel::Reservation.new(start_date, end_date)
    end
    
    def find_available_rooms(start_date, end_date)
      @rooms.map do |room|
        room
      end
    end
    
    def list_reservations_by_date(date)
      @reservations.map do |reservation|
        # Currently includes end date in search, may want to alter.
        if (reservation.dates.include? Date.parse(date)) || (reservation.end_date == Date.parse(date))
          reservation
        end
      end
    end
    
  end
end
