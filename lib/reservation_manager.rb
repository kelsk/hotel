require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations
    
    def initialize(rooms: Hotel::Room.load_all, reservations: [])
      @rooms = rooms
      @reservations = reservations
      @calendar = Hotel::Calendar.new
    end
    
    def create_reservation(start_date, end_date)
      check_dates = @calendar.get_date_range(start_date, end_date)
      check_overlap = @calendar.overlap?(check_dates, @reservations)
      room = find_available_rooms(start_date, end_date).first
      if room != nil
        @reservations << Hotel::Reservation.new(start_date, end_date, room)
      else 
        raise ArgumentError, "There are no rooms available for those dates."
      end
    end
    
    def find_available_rooms(start_date, end_date)
      search_range = @calendar.get_date_range(start_date, end_date)
      
      # reserved_dates = @reservations.map do |reservation|
      #   reservation.dates
      # end
      
      # overlaps = @calendar.overlap?(search_range, reserved_dates)
      
      available_rooms_by_id = @rooms.map { |room| room.id }
      
      @reservations.each do |reservation|
        dates = reservation.dates
        overlaps = @calendar.overlap?(search_range, dates)
        if overlaps == true
          available_rooms_by_id = available_rooms_by_id - [reservation.room.id]
        end
      end
      
      available_rooms = available_rooms_by_id.map do |id| 
        get_rooms_by_id(id)
      end
    end
    
    def get_rooms_by_id(id)
      rooms_by_id = []
      @rooms.find do |room|
        if room.id == id
          rooms_by_id << room
        end
      end
    end
    
    def list_reservations_by_date(date)
      @reservations.map do |reservation|
        # Currently includes end date in search, may want to alter.
        if (reservation.dates.include? date) || (reservation.end_date == date)
          reservation
        end
      end
    end
    
  end
end
