require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations
    
    def initialize
      @rooms = Hotel::Room.load_all
      @reservations = []
    end
    
    def create_reservation(start_date, end_date)
      new_reservation = Hotel::Reservation.new(start_date, end_date, 13)
      @reservations << new_reservation
    end
    
    def find_available_rooms(start_date, end_date)
      @rooms.map do |room|
        room
      end
      
    end
    
  end
end
