require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations
    
    def initialize(rooms: [], reservations: [])
      @rooms = Hotel::Room.load_all
      @reservations = reservations
      @calendar = Hotel::Calendar.new
    end
    
    def create_reservation(start_date, end_date, room: 1)
      room = find_available_rooms(start_date, end_date).first
      @reservations << Hotel::Reservation.new(start_date, end_date, room)
    end
    
    def find_available_rooms(start_date, end_date)
      search_range = @calendar.get_date_range(start_date, end_date)
      
      reserved_dates = @reservations.map do |reservation|
        reservation.dates
      end
      
      # overlaps = @calendar.overlap?(search_range, reserved_dates)
      
      
      available_rooms_by_id = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      
      @reservations.each do |reservation|
        dates = reservation.dates
        overlaps = @calendar.overlap?(search_range, dates)
        if !overlaps
          available_rooms_by_id = available_rooms_by_id - [reservation.room.id]
        end
      end
      
      # available_rooms_by_id 
      
      # unavailability = @reservations.select do |reservation|
      #   reservation.dates - search_range == [] 
      # end
      
      # unavailability.map! { |res| res.room.id }
      # rooms_by_id = @rooms.map { |room| room.id }
      
      # availability = rooms_by_id - unavailability
      
      # available_rooms = @rooms.select do |room|
      #   # availability.include? room.id
      #   available_rooms_by_id.include? room.id
      # end
      
      available_rooms = available_rooms_by_id.map do |id| 
        get_rooms_by_id(id)
      end
      return available_rooms
      # @rooms.map do |room|
      #   if !unavailability.include? room.id 
      #     room
      #   end
      # end
    end
    
    def get_rooms_by_id(id)
      rooms_by_id = []
      @rooms.select do |room|
        if room.id == id
          rooms_by_id << room
        end
      end
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
