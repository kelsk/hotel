require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations
    
    def initialize
      @rooms = Hotel::Room.load_all
      @reservations = []
      @calendar = Hotel::Calendar.new
    end
    
    def create_reservation(start_date, end_date)
      room = self.find_available_rooms(start_date, end_date)[0]
      @reservations << Hotel::Reservation.new(start_date, end_date, room)
    end
    
    def find_available_rooms(start_date, end_date)
      search_range = @calendar.get_date_range(start_date, end_date)
      unavailability = @reservations.select do |reservation|
        reservation.dates - search_range == [] 
      end
      unavailability.map! { |res| res.room_id }
      rooms_by_id = @rooms.map { |room| room.id }
      
      availability = rooms_by_id - unavailability
      
      available_rooms = @rooms.select do |room|
        availability.include? room.id
      end
      return available_rooms
      # @rooms.map do |room|
      #   if !unavailability.include? room.id 
      #     room
      #   end
      # end
    end
    
    def list_reservations_by_date(date)
      @reservations.map do |reservation|
        # Currently includes end date in search, may want to alter.
        # REMOVE DATE.PARSE, ONLY USE IN TEST
        if (reservation.dates.include? date) || (reservation.end_date == date)
          reservation
        end
      end
    end
    
  end
end
