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
    
    def request_reservation(start_date, end_date, type: :room, block_id: nil, amount: 1)
      block_ids = @blocks.map {|block| block.id}
      if block_ids.include? block_id
        if type == :block
          raise ArgumentError, "You may not reserve a block within a block."
        else
          reserve_in_block(start_date, end_date, block_id)
        end
      else
        available_rooms = find_available_rooms(start_date, end_date)
        if type == :block 
          if amount > 5 || amount < 1
            raise ArgumentError, "You may only reserve up to 5 rooms."
          elsif available_rooms.length < amount
            raise ArgumentError, "There are not enough available rooms for those dates."
          else 
            create_block(start_date, end_date, available_rooms[0...amount])
          end
        elsif type == :room
          if available_rooms.first == nil
            raise ArgumentError, "There are no rooms available for those dates."
          else
            create_reservation(start_date, end_date, available_rooms.first)
          end
        end
      end
    end
    
    def create_block(start_date, end_date, room)
      block = Hotel::Block.new(start_date, end_date, room)
      @blocks << block
      return block
    end
    
    def create_reservation(start_date, end_date, room, discount: discount)
      reservation = Hotel::Reservation.new(start_date, end_date, room, discount: discount)
      @reservations << reservation
      return reservation
    end
    
    def reserve_in_block(start_date, end_date, id)
      block_to_reserve = nil
      @blocks.find do |block| 
        block.id == id
        block_to_reserve = block
      end
      if start_date == block_to_reserve.start_date && end_date == block_to_reserve.end_date
        room_to_reserve = find_available_rooms(start_date, end_date, rooms: block_to_reserve.rooms).first
        if room_to_reserve == nil
          raise ArgumentError, "There are no available rooms in this block."
        else
          reservation = create_reservation(start_date, end_date, room_to_reserve, discount: block_to_reserve.discount)
          block_to_reserve.add_reservation_to_block(reservation)
          return reservation
        end
      else
        raise ArgumentError, "The reservation dates must be the same as the reserved block dates."
      end
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
        # Currently includes end date in search parameters
        reservation if (reservation.dates.include? date) || (reservation.end_date == date)
      end
      reservations.compact
    end
    
  end
end
