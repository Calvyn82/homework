module FreedomUnits
  class Temperature
    def initialize(fahrenheit)
      @fahrenheit = fahrenheit
    end

    attr_reader :fahrenheit

    def to_celsius
      (fahrenheit - 32) * (5.0 / 9.0)
    end

    def to_farhenheit
      fahrenheit
    end
  end
end
