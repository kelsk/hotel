module Hotel
  
  class Block < Reservation
    
    attr_reader :start_date, :end_date
    attr_accessor :id, :rooms, :dates, :discount, :reserved_rooms, :reservations
    
    def initialize(start_date, end_date, room, discount: 0.8)
      super(start_date, end_date, room)
      @id = create_block_id
      @rooms = room
      @discount = discount
      @reserved_rooms = []
      @reservations = []
    end
    
    def create_block_id
      "#{@start_date.year % 100}#{@start_date.month}#{@start_date.day}#{rand(9999)}B"
    end
    
    def add_reservation_to_block(reservation)
      @reserved_rooms << reservation.room
      @reservations << reservation
      @rooms.delete reservation.room
    end
    
    def calculate_total_cost
      total_cost = @reservations.map do |reservation|
        @room = reservation.room
        super 
      end
      total_cost.sum
    end
    
  end
end
