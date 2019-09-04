require_relative 'test_helper'

describe "Calendar" do
  
  before do
    @calendar = Hotel::Calendar.new
  end
  
  it "creates an instance of Calendar" do
    expect(@calendar).must_be_instance_of Hotel::Calendar 
  end
  
  it "raises an exception a start date is earlier than today" do
    date = Date.parse('2019-09-03')
    
    expect{@calendar.get_date_range(date)}.must_raise ArgumentError 
  end
  
  it "raises an exception when a start date is earlier or the same as an end date" do
    start_date = Date.parse('2019-10-31')
    end_date = Date.parse('2019-10-31')
    
    expect{@calendar.get_date_range(start_date, end_date)}.must_raise ArgumentError    
  end
  
  it "returns a date range of valid dates" do
    start_date = Date.parse('2019-10-31')
    end_date = Date.parse('2019-11-04')
    
    expect(@calendar.get_date_range(start_date, end_date)).must_be_instance_of Array
    expect(@calendar.get_date_range(start_date, end_date)[1].to_s).must_equal '2019-11-01'
  end
  
end
