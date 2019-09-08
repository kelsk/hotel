require_relative 'test_helper'

describe "Block" do
  
  before do
    @hotel = Hotel::ReservationManager.new
    
    @test_rooms = []
    5.times do |i|
      @test_rooms << @hotel.rooms[i]
    end
    
    @block = Hotel::Block.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms, discount: 0.8)    
    @hotel.blocks << @block
  end
  
  it "initializes a Block" do
    expect(@block).must_be_instance_of Hotel::Block
  end
  
  it "includes all dates from checkin to checkout in a Block" do
    expect(@block.dates).must_be_instance_of Array
    expect(@block.dates[1].to_s).must_equal '2019-11-01' 
    expect(@block.dates.length).must_equal 4 
  end
  
  it "adds up to 5 rooms to a Block" do
    new_block = @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 5)
    expect(new_block).must_be_instance_of Hotel::Block
    expect(new_block.rooms).must_be_instance_of Array
    expect(new_block.rooms[0]).must_be_instance_of Hotel::Room
    expect(new_block.rooms.length).must_equal 5
  end
  
  it "raises an exception if adding more than 5 rooms to a Block" do
    expect { @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 10) }.must_raise ArgumentError
    expect { @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 0) }.must_raise ArgumentError    
  end
  
  
  it "raises an exception if a room is unavailable" do
    # reserves 16 rooms to prevent a block of 5 from being created
    16.times do
      @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'))
    end
    
    expect{@hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 5)}.must_raise ArgumentError
  end
  
  it "raises an exception if adding a Block to a Block" do 
    expect { @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, block_id: @block.id, amount: 5) }.must_raise ArgumentError
  end
  
  it "calculates the total cost of a room in a Block" do
    @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    total_cost = @block.calculate_total_cost
    
    expect(total_cost).must_equal 640.00
  end
  
  it "reserves a room in a Block" do
    reservation = @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    
    expect(@block.reserved_rooms.length).must_equal 1
    expect(@block.rooms.length).must_equal 4
  end
  
  it "returns a list of available rooms in a Block" do
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'), rooms: @block.rooms)
    expect(available_rooms.length).must_equal 5
    
    # returns only 4 available rooms after a reservation is made
    reservation = @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'), rooms: @block.rooms)
    expect(available_rooms.length).must_equal 4
  end
  
  it "raises an exception if reservation dates are outside of Block" do
    id = @block.id
    @hotel.blocks << @block
    
    expect { @hotel.request_reservation(Date.parse('2019-11-01'), Date.parse('2019-11-03'), block_id: id) }.must_raise ArgumentError
    expect { @hotel.request_reservation(Date.parse('2019-10-21'), Date.parse('2019-11-04'), block_id: id) }.must_raise ArgumentError
    expect { @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-03'), block_id: id) }.must_raise ArgumentError
    expect { @hotel.request_reservation(Date.parse('2019-10-30'), Date.parse('2019-11-05'), block_id: id) }.must_raise ArgumentError
  end
end
