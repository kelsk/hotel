require_relative 'test_helper'

describe "Block" do
  
  before do
    @hotel = Hotel::ReservationManager.new
    
    @test_rooms = []
    5.times do |i|
      @test_rooms << @hotel.rooms[i]
    end
    
    @block = Hotel::Block.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms)
    
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
  
  it "raises an exception if a room is unavailable" do
    expect{@hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 15)}.must_raise ArgumentError
    16.times do
      @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'))
    end
    expect{@hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :block, amount: 5)}.must_raise ArgumentError
  end
  
  it "raises an exception if adding a Block to a Block" do
    
  end
  
  it "adds a date range to a Block" do
    expect(@block.dates).must_be_instance_of Array
    expect(@block.dates[0].to_s).must_equal '2019-10-31'
  end
  
  it "calculates the total cost of a room in a Block" do
    puts @block.list_discounted_rates
  end
  
  it "reserves a room in a Block" do
    reservation = @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'))
    @block.add_reservation_to_block(reservation)
    expect(@block.reserved_rooms.length).must_equal 1
    expect(@block.rooms.length).must_equal 4
    # expect dates are full duration
  end
  
  it "can check whether a room in a Block is available" do
  end
  
  it "raises an exception if reservation dates are outside of Block" do
    # expect block.reservation raises argument error
  end
  
  
end
