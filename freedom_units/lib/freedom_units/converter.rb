require_relative "temperature"

module FreedomUnits
  class Converter
    def initialize(temperature)
      @temperature = temperature
    end

    attr_reader :temperature

    def convert
      if temperature.downcase.end_with?("f")
        "#{Temperature.new(temperature.to_f).to_celsius}C"
      else
        "#{Temperature.new(temperature.to_f * (9.0 / 5.0) + 32).to_farhenheit}F"
      end
    end
  end
end
