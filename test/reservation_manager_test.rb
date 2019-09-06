require_relative 'test_helper'

describe "Reservation Manager" do
  
  before do
    # staging for Wave 2 tests
    @test_rooms = []
    
    20.times do |i|
      @test_rooms << Hotel::Room.new(i+1)
    end
    
    @test_reservations = [
      Hotel::Reservation.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms[0]), #index 0
      Hotel::Reservation.new(Date.parse('2019-10-29'), Date.parse('2019-10-31'), @test_rooms[1]), #index 1
      Hotel::Reservation.new(Date.parse('2019-10-28'), Date.parse('2019-10-31'), @test_rooms[2]), #index 2
      Hotel::Reservation.new(Date.parse('2019-11-01'), Date.parse('2019-11-03'), @test_rooms[3]), #index 3
      Hotel::Reservation.new(Date.parse('2019-11-01'), Date.parse('2019-11-05'), @test_rooms[4]), #index 4
      Hotel::Reservation.new(Date.parse('2019-10-25'), Date.parse('2019-11-05'), @test_rooms[5]) #index 5
    ]
    
    @hotel = Hotel::ReservationManager.new(rooms: @test_rooms, reservations: @test_reservations)
    
    
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
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'))
    # wave 1: all rooms are available
    # expect(available_rooms.length).must_equal 20
    
    # wave 2: only some rooms are available, must_equal 20 is no longer valid
    expect(available_rooms.length).must_equal 17
  end
  
  it "returns a list of reservations for a given date" do
    # expect reservation_manager.list_reservations_by_date(whatever date)
    # will return the reservations whose @dates includes whatever date
    
    reservations_by_date = @hotel.list_reservations_by_date(Date.parse('2019-10-31'))
    
    expect(reservations_by_date).must_be_instance_of Array
    expect(reservations_by_date[0].start_date.to_s).must_equal '2019-10-31'
    expect(reservations_by_date[1].start_date.to_s).must_equal '2019-10-29'
  end
  
  it "raises an exception if there are no rooms available for a date range" do
    
    # adds conflicting reservations
    14.times do |i|
      @test_reservations << Hotel::Reservation.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms[i + 6])
    end
    
    expect{ @hotel.create_reservation(Date.parse('2019-10-22'), Date.parse('2019-11-05')) }.must_raise ArgumentError
  end
  
  
end
