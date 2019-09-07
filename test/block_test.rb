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
    expect(@block.rooms).must_be_instance_of Array
    expect(@block.rooms[0]).must_be_instance_of Hotel::Room
    expect(@block.rooms.length).must_equal 5
  end
  
  it "calculates the total cost of a room in a Block" do
    puts @block.list_discounted_rates
  end
  
  it "reserves a room in a Block" do
    reservation = @hotel.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'))
    @block.add_reservation_to_block(reservation)
    expect(@block.reserved_rooms.length).must_equal 1
    expect(@block.rooms.length).must_equal 4
  end
  
end
