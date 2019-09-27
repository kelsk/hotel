describe "Reservation Manager" do
  
  before do
    
    @test_rooms = []
    
    20.times do |i|
      @test_rooms << Hotel::Room.new(i+1)
    end
    
    @test_reservations = [
      Hotel::Reservation.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @test_rooms[0]),
      Hotel::Reservation.new(Date.parse('2019-10-29'), Date.parse('2019-10-31'), @test_rooms[1]),
      Hotel::Reservation.new(Date.parse('2019-10-28'), Date.parse('2019-10-31'), @test_rooms[2]),
      Hotel::Reservation.new(Date.parse('2019-11-01'), Date.parse('2019-11-03'), @test_rooms[3]),
      Hotel::Reservation.new(Date.parse('2019-11-01'), Date.parse('2019-11-05'), @test_rooms[4]),
      Hotel::Reservation.new(Date.parse('2019-10-25'), Date.parse('2019-11-05'), @test_rooms[5])
    ]
    
    @hotel = Hotel::ReservationManager.new(rooms: @test_rooms, reservations: @test_reservations)
    
  end
  
  
  it "creates an instance of Reservation Manager" do
    expect(@hotel).must_be_instance_of Hotel::ReservationManager
    
    # ensures that arguments are optional
    hotel_without_args = Hotel::ReservationManager.new
    expect(hotel_without_args).must_be_instance_of Hotel::ReservationManager
  end
  
  it "returns a list of all the rooms" do
    expect(@hotel.rooms.length).must_equal 20
  end
  
  # it "creates a new reservation" do
  #   expect(@hotel.create_reservation(Date.parse('2019-10-01'), Date.parse('2019-10-05'), @test_rooms[6])).must_be_instance_of Hotel::Reservation
  # end
  
  # it "creates a reservation for a given date range" do
  #   new_reservation = @hotel.reservations[0]
    
  #   expect(new_reservation.start_date.to_s).must_equal '2019-10-31'
  #   expect(new_reservation.end_date.to_s).must_equal '2019-11-04'
  # end
  
  it "returns a list of available rooms" do
    available_rooms = @hotel.find_available_rooms(Date.parse('2019-10-28'), Date.parse('2019-10-31'))
    # rooms 2, 3, and 6 are unavailable
    expect(available_rooms.length).must_equal 17
  end
  
  it "returns a list of reservations for a given date" do
    reservations_by_date = @hotel.list_reservations_by_date(Date.parse('2019-10-31'))
    # rooms 1, 2, 3, and 6 include this date
    expect(reservations_by_date).must_be_instance_of Array
    expect(reservations_by_date.length).must_equal 4
    expect(reservations_by_date[0].start_date.to_s).must_equal '2019-10-31'
  end
  
  
  
end
