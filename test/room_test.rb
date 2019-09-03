describe "Room" do
  it "creates an instance of Room" do
    room = Hotel::Room.new(13)
    
    expect(room).must_be_instance_of Hotel::Room
  end
  
end
