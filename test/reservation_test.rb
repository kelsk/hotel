describe "Reservation" do
  
  before do
    @manager = Hotel::ReservationManager.new
    @room = Hotel::Room.new(1)
    @reservation = Hotel::Reservation.new(Date.parse('2019-10-31'), Date.parse('2019-11-04'), @room)
  end
  
  it "initializes a Reservation" do    
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  
  it "includes all dates between checkin and checkout in a reservation" do
    expect(@reservation.dates).must_be_instance_of Array
    expect(@reservation.dates[1].to_s).must_equal '2019-11-01' 
    expect(@reservation.dates.length).must_equal 4 
  end
  
  it "adds a Room to a Reservation" do
    expect(@reservation.room.id).must_equal 1
  end
  
  it "calculates the total cost for a Reservation" do
    expect(@reservation.calculate_total_cost).must_equal 800
  end
  
end
