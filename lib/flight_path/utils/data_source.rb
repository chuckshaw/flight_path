module FlightPath
  class DataSource
    # Worksheet Column Constants
    ORDER_INDEX             = 0  # Waypoint order.
    LAT_INDEX               = 5  # Latitude values.
    LAT_ORIENTATION_INDEX   = 6
    LON_INDEX               = 7  # Longitude values.
    LON_ORIENTATION_INDEX   = 8
    GROUND_SPEED_INDEX      = 9
    TRACK_ANGLE_INDEX       = 10
    MAGNETIC_VARIANCE_INDEX = 14
    POSITION_SYSTEM_INDEX   = 15
    HEADING_INDEX           = 17
    HEADING_TYPE_INDEX      = 18
    ROLL_INDEX              = 19
    PITCH_INDEX             = 20
    
    def initialize(file)
      @file = file
      @logger = Logger.new(STDOUT)
      #@logger.level = Logger::ERROR
      @logger.level = Logger::DEBUG
      
      @logger.info "Loading Excel Spreadsheet: #{file}"
      @wb = RubyXL::Parser.parse(@file)
      @ws = @wb.worksheets[1]
    end
    
    def data()
      data = {}
      sheet_data = @wb.worksheets[1].sheet_data
      
      sheet_data.rows.each_with_index do |row, index|
        if index != 0
          wp = { lat: row[LAT_INDEX].value, lon: row[LON_INDEX].value }
          data[row[ORDER_INDEX].value] = wp
        end
      end
      
      return data
    end
    
    def update(index, data)
      @logger.debug "Updating Row: #{index+1} with Data: #{data}."
     
      @ws[index][LAT_INDEX].change_contents(data[:lat])
      @ws[index][LAT_ORIENTATION_INDEX].change_contents(data[:lat_orientation])
      @ws[index][LON_INDEX].change_contents(data[:lon])
      @ws[index][LON_ORIENTATION_INDEX].change_contents(data[:lon_orientation])
      @ws[index][GROUND_SPEED_INDEX].change_contents(data[:ground_speed])
      @ws[index][TRACK_ANGLE_INDEX].change_contents(data[:track_angle])
      @ws[index][MAGNETIC_VARIANCE_INDEX].change_contents(data[:mag_variation])
      @ws[index][POSITION_SYSTEM_INDEX].change_contents(data[:position_system])
      @ws[index][HEADING_INDEX].change_contents(data[:heading])
      @ws[index][HEADING_TYPE_INDEX].change_contents(data[:heading_type])
      @ws[index][ROLL_INDEX].change_contents(data[:roll])
      @ws[index][PITCH_INDEX].change_contents(data[:pitch])
    end
    
    def save()
      @wb.write(@file)
    end
    
  end
end