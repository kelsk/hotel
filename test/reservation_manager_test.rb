require_relative 'test_helper'

describe "Reservation Manager" do
  
  before do
    @hotel = Hotel::ReservationManager.new
  end
  
  
  it "creates an instance of Reservation Manager" do
    expect(@hotel).must_be_instance_of Hotel::ReservationManager
  end
  
  it "returns a list of all the rooms" do
    expect(@hotel.rooms.length).must_equal 20
  end
  
  it "creates a new reservation" do
    @hotel.create_reservation('2019-10-31', "2019-11-04")
    
    expect(@hotel.reservations.length).must_equal 1
  end
  
  it "returns a list of available rooms" do
    new_reservation = @hotel.create_reservation('2019-10-01', '2019-10-11')
    available_rooms = @hotel.find_available_rooms('2019-10-03', '2019-10-11')
    
    expect(available_rooms.length).must_equal 20
  end
  
  
end
