describe "Reservation Creator \n***\n***\n***\n***\n***\n***\n***\n***\n***" do
  before do
    @reservation_creator = Hotel::ReservationCreator.new
    
  end
  
  it "initializes a ReservationCreator with inherited instance variables" do
    expect(Hotel::ReservationCreator.new).must_be_instance_of Hotel::ReservationCreator
    expect(@reservation_creator.rooms).must_be_instance_of Array
    expect(@reservation_creator.rooms[0]).must_be_instance_of Hotel::Room
  end
  
  it "creates a new reservation" do
    expect(@reservation_creator.create_reservation(Date.parse('2019-10-01'), Date.parse('2019-10-05'), @reservation_creator.rooms[0])).must_be_instance_of Hotel::Reservation
    expect(@reservation_creator.reservation_manager.reservations[0]).must_be_instance_of Hotel::Reservation
  end
  
  it "creates a reservation for a given date range" do
    new_reservation = @reservation_creator.create_reservation(Date.parse('2019-10-01'), Date.parse('2019-10-05'), @reservation_creator.rooms[0])
    
    expect(new_reservation.start_date.to_s).must_equal '2019-10-01'
    expect(new_reservation.end_date.to_s).must_equal '2019-10-05'
  end
  
  it "raises an exception if there are no rooms available for a date range" do
    
    # adds conflicting reservations to test data
    14.times do |i|
      @test_reservations << Hotel::Reservation.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms[i + 6])
    end
    
    expect{ @reservation_creator.request_reservation(Date.parse('2019-10-22'), Date.parse('2019-11-05')) }.must_raise ArgumentError
  end
  
  
  # BLOCKS
  
  before do
    @reservation_creator = Hotel::ReservationCreator.new
    @test_rooms = []
    5.times do |i|
      @test_rooms << @reservation_creator.reservation_manager.rooms[i]
    end
    @block = Hotel::Block.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms, discount: 0.8)
    @reservation_creator.reservation_manager.blocks << @block  
  end
  
  it "reserves a room in a Block" do
    @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    
    expect(@block.reserved_rooms.length).must_equal 1
    expect(@block.rooms.length).must_equal 4
  end
  
  it "raises an exception if a reservation is made for a Block that doesn't exist" do
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: 'notablock') }.must_raise ArgumentError
  end
  
  it "adds up to 5 rooms to a Block" do
    new_block = @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 5)
    expect(new_block).must_be_instance_of Hotel::Block
    expect(new_block.rooms).must_be_instance_of Array
    expect(new_block.rooms[0]).must_be_instance_of Hotel::Room
    expect(new_block.rooms.length).must_equal 5
  end
  
  it "raises an exception if adding more than 5 rooms to a Block" do
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 10) }.must_raise ArgumentError
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 0) }.must_raise ArgumentError    
  end
  
  
  it "raises an exception if a room is unavailable" do
    # reserves 16 rooms to prevent a block of 5 from being created
    16.times do
      @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'))
    end
    
    expect{@reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 5)}.must_raise ArgumentError
  end
  
  it "raises an exception if adding a Block to a Block" do 
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, block_id: @block.id, amount: 5) }.must_raise ArgumentError
  end
  
  
  it "raises an exception if reservation dates are outside of Block" do
    id = @block.id
    @reservation_creator.blocks << @block
    
    expect { @reservation_creator.request_reservation(Date.parse('2019-11-01'), Date.parse('2019-11-03'), block_id: id) }.must_raise ArgumentError
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-21'), Date.parse('2019-11-04'), block_id: id) }.must_raise ArgumentError
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-03'), block_id: id) }.must_raise ArgumentError
    expect { @reservation_creator.request_reservation(Date.parse('2019-10-30'), Date.parse('2019-11-05'), block_id: id) }.must_raise ArgumentError
  end
  
end