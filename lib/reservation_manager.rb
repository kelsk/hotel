require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_reader :reservations
    attr_accessor :rooms
    
    def initialize(rooms, reservations)
      @rooms = Hotel::Room.load_all
      @reservations = reservations
    end
    
  end
end
