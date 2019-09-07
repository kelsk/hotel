module Hotel
  
  class Block < Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :rooms, :dates, :discount, :reserved_rooms, :reservations
    
    def initialize(start_date, end_date, room, discount: 0.80)
      super(start_date, end_date, room)
      @rooms = room
      @discount = discount
      @reserved_rooms = []
      @reservations = []
    end
    
    def add_reservation_to_block(reservation)
      puts @rooms.length
      reservation.room = @rooms.first
      @reserved_rooms << reservation.room
      @rooms.delete reservation.room
      puts @rooms.length
    end
    
    def list_discounted_rates
      @rooms.map! do |room|
        room.rate = room.rate * @discount
      end
    end
    
    
  end
end
