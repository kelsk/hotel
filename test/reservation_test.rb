require_relative 'test_helper'

describe "reservations" do
  
  it "initializes a Reservation" do
    reservation = Hotel::Reservation.new("today", "tomorrow")
    
    expect(reservation).must_be_kind_of Hotel::Reservation
  end
  
end
