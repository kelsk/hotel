require 'date'

module Hotel
  
  class Calendar
    
    attr_reader :today
    
    def initialize
      @today = Date.today
    end
    
    def valid_start_date?(start_date)
      # This hotel does not accept reservations made on the current day.
      start_date > @today ? true : false
    end
    
    def valid_end_date?(start_date, end_date)
      # This hotel does not accept one-day reservations.
      start_date < end_date ? true : false
    end
    
    def get_date_range(start_date, end_date)
      if !valid_start_date?(start_date)
        raise ArgumentError, 'Start date cannot be current date.'
      elsif !valid_end_date?(start_date, end_date)
        raise ArgumentError, 'End date must be later than start date.'
      else
        # gets the date range between start & end dates, minus the checkout date
        (start_date...end_date).to_a
      end
    end
  end  
end
