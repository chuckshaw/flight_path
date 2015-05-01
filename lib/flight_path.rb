require_relative "flight_path/version"
require 'rubyXL'
require_relative 'flight_path/utils/data_source.rb'
require_relative 'flight_path/utils/calculate.rb'
require 'geocoder'
require 'logger'

module FlightPath
  # Your code goes here...
  class FlightPath
    include Calculations
    def initialize(file)
      @logger = Logger.new(STDOUT)
      #@logger.level = Logger::ERROR
      @logger.level = Logger::DEBUG
      
      @logger.info "Setting up data source."
      @ds = DataSource.new(file)
      #ds = DataSource.new('../../data/MessageSpreadsheet.xlsx')
    end
    
    def run
      @logger.info "Calculating Flight Path..."
      data = @ds.data()
      @logger.debug data
      
      origin_wp = []
      dest_wp = []
      data.values.each_with_index do |wp, index|
        if index == 0
          origin_wp = wp.values
          dest_wp = wp.values
        else
          dest_wp = wp.values
        end
        
        result = {}
        result[:lat] = dest_wp[0].to_f.abs
        result[:lon] = dest_wp[1].to_f.abs
        result[:lat_orientation] = latitude_hemispherical_orientation(dest_wp[0].to_f)
        result[:lon_orientation] = longitude_hemispherical_orientation(dest_wp[1].to_f)
        result[:ground_speed] = ground_speed()
        result[:track_angle] = track_angle()
        result[:mag_variation] = magnetic_variation()
        result[:position_system] = position_system()
        result[:heading] = heading(origin_wp, dest_wp)
        result[:heading_type] = heading_type()
        result[:roll] = roll()
        result[:pitch] = pitch()
        
        data[index+1].merge!(result)
        @logger.debug data[index+1]

        origin_wp = dest_wp
      end
      
      @logger.info "Updating Spreadsheet..."
      data.each do |k, v|
        @ds.update(k, v)
      end
      
      @logger.info "Writing Spreadsheet to filesystem..."
      @ds.save
    end
    
  end  
end

if __FILE__ == $0
  fp = FlightPath::FlightPath.new(ARGV.first)
  fp.run
end
