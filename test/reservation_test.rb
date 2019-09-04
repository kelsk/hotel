require_relative 'test_helper'

describe "Reservation" do
  
  before do
    @reservation = Hotel::Reservation.new('2019-10-31', '2019-11-03', 13)
  end
  
  it "initializes a Reservation" do    
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end
  
  it "creates a reservation for a given date range" do
    # expect that an instance of reservation is made:
      # with a start date that is a valid date
      # with an end date that is a valid date
  end

  it "includes all dates between checkin and checkout in a reservation" do
    # expect that reservation.dates returns an array
      # with all the dates between the start date and the end date    
  end

  it "adds a Room to a Reservation" do
    # expect that reservation.room_id will equal 1, for wave 1
    # expect that reservation.room_id will be the first available room, for wave 2
  end

  it "calculates the total cost for a Reservation" do
    # expect that the cost is equal to the date range times the room's base rate (200)
    # reservation from 10/31-11/04 is 4 nights at 200 = $800
  end

  # moved below code to Calendar
  # it "checks whether start_date is a valid date" do
  #   expect(@reservation.start_date).must_be_instance_of Date
  # end
  
  
end
