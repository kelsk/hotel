require_relative 'test_helper'

describe "Block" do
  
  before do
    @reservation_creator = Hotel::ReservationCreator.new
    @hotel = @reservation_creator.reservation_manager
    
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
  
  
  it "calculates the total cost of a room in a Block" do
    @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    total_cost = @block.calculate_total_cost
    
    expect(total_cost).must_equal 640.00
  end
  
  
  it "returns a list of available rooms in a Block" do
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'), rooms: @block.rooms)
    expect(available_rooms.length).must_equal 5
    
    # returns only 4 available rooms after a reservation is made
    @reservation_creator.request_reservation(Date.parse('2019-10-31'), Date.parse('2019-11-04'), type: :room, block_id: @block.id)
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'), rooms: @block.rooms)
    expect(available_rooms.length).must_equal 4
  end
  
end
