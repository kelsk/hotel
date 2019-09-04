require_relative 'test_helper'

describe "Reservation" do
  
  before do
    @reservation = Hotel::Reservation.new('2019-10-31', '2019-11-03', 13)
  end
  
  it "initializes a Reservation" do    
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end
  
  
  # moved below code to Calendar
  # it "checks whether start_date is a valid date" do
  #   expect(@reservation.start_date).must_be_instance_of Date
  # end
  
  
end
