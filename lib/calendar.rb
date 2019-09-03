require 'date'

module Hotel
  
  class Calendar
    
    attr_reader :today
    
    def initialize(today)
      @today = today
    end
    
  end
  
end
