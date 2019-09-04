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
    # wave 1: all rooms are available
    # wave 2: only some rooms are available, must_equal 20 is no longer valid
    expect(available_rooms.length).must_equal 20
  end
  
  it "returns a list of reservations for a given date" do
    # expect reservation_manager.list_reservations_by_date(whatever date)
      # will return the reservations whose @dates includes whatever date
  end

  
end
