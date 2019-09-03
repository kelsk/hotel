require_relative 'test_helper'

describe "Reservation Manager" do
  it "creates an instance of Reservation Manager" do
    res_manager = Hotel::ReservationManager.new("rooms", "reservations")
    
    expect(res_manager).must_be_instance_of Hotel::ReservationManager
    
  end
  
  it "returns a list of all the rooms" do
    new_hotel = Hotel::ReservationManager.new("rooms", "reservations")
    
    room_ids = new_hotel.rooms.map do |room|
      room.room_id
    end
    
    puts room_ids
  end
  
end
