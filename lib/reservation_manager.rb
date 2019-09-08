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
    
    def request_reservation(start_date, end_date, type: :room, amount: 1)
      available_rooms = find_available_rooms(start_date, end_date)
      if type == :block 
        if amount > 5
          raise ArgumentError, "You may only reserve up to 5 rooms."
        elsif available_rooms.length < amount
          raise ArgumentError, "There are not enough available rooms for those dates."
        else 
          create_block(start_date, end_date, available_rooms[0...amount])
        end
      elsif type == :room
        if available_rooms.first != nil
          create_reservation(start_date, end_date, available_rooms.first)
        else
          raise ArgumentError, "There are no rooms available for those dates."
        end
      end
    end
    
    def create_block(start_date, end_date, room)
      block = Hotel::Block.new(start_date, end_date, room)
      @blocks << block
      return block
    end
    
    def create_reservation(start_date, end_date, room)
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservations << reservation
      return reservation
    end
    
    def find_available_rooms(start_date, end_date)
      search_range = @calendar.get_date_range(start_date, end_date)      
      available_rooms_by_id = @rooms.map { |room| room.id }
      
      @reservations.each do |reservation|
        if @calendar.overlap?(search_range, reservation.dates)
          available_rooms_by_id = available_rooms_by_id - [reservation.room.id]
        end
      end
      if available_rooms_by_id[0] == nil
        return [nil]
      else
        available_rooms = available_rooms_by_id.map do |id|
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
        # Currently includes end date in search, may want to alter.
        reservation if (reservation.dates.include? date) || (reservation.end_date == date)
      end
      reservations.compact
    end
    
  end
end
