require_relative 'test_helper'

describe "Calendar" do
  
  it "creates an instance of Calendar" do
    calendar = Hotel::Calendar.new(Date.today)
    
    expect(calendar).must_be_instance_of Hotel::Calendar
    
  end
  
end
