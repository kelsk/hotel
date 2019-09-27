require_relative 'reservation_manager'

module Hotel
  
  class ReservationCreator < Hotel::ReservationManager
    
    attr_reader :reservation_manager
    
    def initialize
      super
      @reservation_manager = Hotel::ReservationManager.new
    end
    
    def create_block(start_date, end_date, room)
      block = Hotel::Block.new(start_date, end_date, room)
      @reservation_manager.blocks << block
      return block
    end
    
    def create_reservation(start_date, end_date, room, discount: discount)
      reservation = Hotel::Reservation.new(start_date, end_date, room, discount: discount)
      @reservation_manager.reservations << reservation
      return reservation
    end
    
    
    def request_reservation(start_date, end_date, type: :room, block_id: nil, amount: 1)
      if block_id
      block_ids = @reservation_manager.blocks.map {|block| block.id}
        if block_ids.include? block_id
          if type == :block
            raise ArgumentError, "You may not reserve a block within a block."
          else
            reserve_in_block(start_date, end_date, block_id)
          end
        else
          raise ArgumentError, "That block does not exist."
        end
      else
        available_rooms = @reservation_manager.find_available_rooms(start_date, end_date)
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
    
    def reserve_in_block(start_date, end_date, id)
      block_to_reserve = @reservation_manager.blocks.find do |block| 
        block.id == id
      end
      if start_date == block_to_reserve.start_date && end_date == block_to_reserve.end_date
        room_to_reserve = @reservation_manager.find_available_rooms(start_date, end_date, rooms: block_to_reserve.rooms).first
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
    
    
  end
  

end