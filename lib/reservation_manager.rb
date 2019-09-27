require_relative 'room'

module Hotel
  class ReservationManager
    
    attr_accessor :rooms, :reservations, :blocks
    
    def initialize(rooms: Hotel::Room.load_all, reservations: [], blocks: [], calendar: Hotel::Calendar.new)
      @rooms = rooms
      @reservations = reservations
      @blocks = blocks
      @calendar = calendar
    end
    

    
    def find_available_rooms(start_date, end_date, rooms: @rooms)
      search_range = @calendar.get_date_range(start_date, end_date)      
      available_rooms_by_id = rooms.map { |room| room.id }
      
      @reservations.each do |reservation|
        if @calendar.overlap?(search_range, reservation.dates)
          available_rooms_by_id = available_rooms_by_id - [reservation.room.id]
        end
      end
      if available_rooms_by_id[0] == nil
        return [nil]
      else
        available_rooms_by_id.map do |id|
          get_rooms_by_id(id)
        end
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
      reservations = @reservations.map do |reservation|
        # Currently includes end date in search parameters
        reservation if (reservation.dates.include? date) || (reservation.end_date == date)
      end
      reservations.compact
    end
    
  end
end
