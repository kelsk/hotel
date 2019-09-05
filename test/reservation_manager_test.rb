require_relative 'test_helper'

describe "Reservation Manager" do
  
  before do
    @hotel = Hotel::ReservationManager.new
    
    # staging for Wave 2 tests
    @hotel.create_reservation('2019-10-31', '2019-11-04') #index 0
    @hotel.create_reservation('2019-10-29', '2019-10-31') #index 1
    @hotel.create_reservation('2019-10-28', '2019-10-31') #index 2
    @hotel.create_reservation('2019-11-01', '2019-11-03') #index 3
    @hotel.create_reservation('2019-11-01', '2019-11-05') #index 4
    @hotel.create_reservation('2019-10-25', '2019-11-05') #index 5
    
  end
  
  
  it "creates an instance of Reservation Manager" do
    expect(@hotel).must_be_instance_of Hotel::ReservationManager
  end
  
  it "returns a list of all the rooms" do
    expect(@hotel.rooms.length).must_equal 20
  end
  
  it "creates a new reservation" do
    expect(@hotel.reservations[1]).must_be_instance_of Hotel::Reservation
  end
  
  it "creates a reservation for a given date range" do
    new_reservation = @hotel.reservations[0]
    
    expect(new_reservation.start_date.to_s).must_equal '2019-10-31'
    expect(new_reservation.end_date.to_s).must_equal '2019-11-04'
  end
  
  it "returns a list of available rooms" do
    new_reservation = @hotel.reservations[2]
    expect(new_reservation.start_date.to_s).must_equal '2019-10-28'
    available_rooms = @hotel.find_available_rooms('2019-10-28', '2019-10-31')
    # wave 1: all rooms are available
    # wave 2: only some rooms are available, must_equal 20 is no longer valid
    expect(available_rooms.length).must_equal 20
  end
  
  it "returns a list of reservations for a given date" do
    # expect reservation_manager.list_reservations_by_date(whatever date)
    # will return the reservations whose @dates includes whatever date
    
    reservations_by_date = @hotel.list_reservations_by_date('2019-10-31')
    
    expect(reservations_by_date).must_be_instance_of Array
    expect(reservations_by_date[0].start_date.to_s).must_equal '2019-10-31'
    expect(reservations_by_date[1].start_date.to_s).must_equal '2019-10-29'
  end
  
  
end
