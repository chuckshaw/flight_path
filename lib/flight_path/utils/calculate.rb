module FlightPath
  module Calculations
    
    ## Heading in degrees (000 - 360.00, where 0.00 is North, 180.0 is South)
    def heading(origin, destination)
      return Geocoder::Calculations.bearing_between(origin, destination)
    end
    
    ## Heading Type is either "T"rue North or "M"agnetic North.
    def heading_type()
      # Using a default for first version
      return heading_type = 'T'
    end
    
    def position_system()
      # Defaulting to Autonomous Mode
      return position_system = 'A'
    end
    
    ## The speed of the aircraft in Meters/Second
    def ground_speed()
      # Using a default for first version
      return 256.3
    end
    
    def roll()
      # Using a default for first version
      return 0
    end
    
    def pitch()
      return 0
    end
    
    ## The error between "True North" and the actual "Magnetic North".
    def magnetic_variation()
      # Using a default for first version
      return 1.89
    end
    
    ## The tracking angle is the angle between the course to steer and the course.  The heading is the direction to which the "nose" of the vehicle is pointing.
    ## http://en.wikipedia.org/wiki/Course_%28navigation%29
    def track_angle()
      # Using a default for first version
      # Assuming the aircraft heading is perfectly on the route.
      return 0
    end
    
    ## Single character that indicates the Longitude hemisphere
    ## Positive longitude is "E" (East) and Negative longitude is "W" (West)
    def longitude_hemispherical_orientation(value)
      orientation = 'E'
      if value < 0
        orientation = 'W'
      end
      return orientation
    end
    
    ## Single character that indicates the Latitude hemisphere
    ## Positive latitude is "N" (North) and Negative latitude is "S" (South)
    def latitude_hemispherical_orientation(value)
      orientation = 'N'
      if value < 0
        orientation = 's'
      end
      return orientation
    end
    
  end
end