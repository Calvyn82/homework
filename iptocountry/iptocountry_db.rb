DB_FILE = "ip_db.txt"

class IPConverter
  def initialize(ip_address)
    @ip_address = ip_address
  end

  attr_reader :ip_address

  def to_i
    chunks = ip_address.split(".").reverse
    sum = 0
    chunks.each_with_index do |chunk, i|
      sum += chunk.to_i * (256 ** i)
    end
    return sum
  end
end

class IPDatabaseBuilder
  FIELD_SIZE  = IPConverter.new("255.255.255.255").to_i.to_s.size
  LINE_SIZE   = FIELD_SIZE * 2 + 5

  def initialize(filename = "IpToCountry.csv")
    @filename = filename
  end

  attr_reader :filename

  def construct
    File.open(DB_FILE, "w") do |db|
      File.foreach(filename) do |line|
        if !line.start_with?("#")
          fields  = line.delete('"').split(",")
          from_ip = fields[0].ljust(FIELD_SIZE)
          to_ip   = fields[1].ljust(FIELD_SIZE)
          country = fields[4]
          db.puts "#{from_ip} #{to_ip} #{country}"
        end
      end
    end
  end
end

class LinearSearch
  def initialize(ip_address, filename = DB_FILE)
    @ip_address = IPConverter.new(ip_address).to_i
    @filename   = filename
  end

  attr_reader :ip_address, :filename

  def search
    File.foreach(filename) do |line|
      fields = line.split
      from_ip = fields[0].to_i
      to_ip = fields[1].to_i
      country = fields[2]
      if (from_ip..to_ip).include?(ip_address)
        return country
      end
    end
    "No available country"
  end
end

class BinarySearch
  def initialize(ip_address, filename = DB_FILE)
    @ip_address = IPConverter.new(ip_address).to_i
    @filename   = filename
  end

  attr_reader :ip_address, :filename

  def search
    file_size = File.size(DB_FILE)
    lines     = file_size/IPDatabaseBuilder::LINE_SIZE
    low       = 0
    high      = lines - 1
    File.open(DB_FILE, "r") do |db|
      while high >= low
        middle = (high - low)/2 + low
        db.seek(middle * IPDatabaseBuilder::LINE_SIZE)
        fields = db.gets.split
        from_ip = fields[0].to_i
        to_ip   = fields[1].to_i
        country = fields[2]
        if (from_ip..to_ip).include?(ip_address)
          return country
        elsif ip_address < from_ip
          high  = middle - 1
        elsif ip_address > to_ip
          low   = middle + 1
        end
      end
    end
    "No available country"
  end
end

unless File.exist?(DB_FILE)
  IPDatabaseBuilder.new.construct
end

ip_address = ARGV.first
puts BinarySearch.new(ip_address).search
