require_relative 'test_helper'

describe "Reservation" do
  
  before do
    @reservation = Hotel::Reservation.new('2019-10-31', '2019-11-04')
  end
  
  it "initializes a Reservation" do    
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  
  
  it "includes all dates between checkin and checkout in a reservation" do
    # expect that reservation.dates returns an array
    expect(@reservation.dates).must_be_instance_of Array
    # with all the dates between the start date and the end date    
    expect(@reservation.dates[1].to_s).must_equal '2019-11-01' 
    expect(@reservation.dates.length).must_equal 4 
  end
  
  it "adds a Room to a Reservation" do
    # expect that reservation.room_id will equal 1, for wave 1
    expect(@reservation.room_id).must_equal 1
    # expect that reservation.room_id will be the first available room, for wave 2
  end
  
  it "calculates the total cost for a Reservation" do
    # expect that the cost is equal to the date range times the room's base rate (200)
    # reservation from 10/31-11/04 is 4 nights at 200 = $800
    expect(@reservation.calculate_total_cost).must_equal 800
  end
  
  # moved below code to Calendar
  # it "checks whether start_date is a valid date" do
  #   expect(@reservation.start_date).must_be_instance_of Date
  # end
  
  
end
