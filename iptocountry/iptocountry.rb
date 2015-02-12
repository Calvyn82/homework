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

class Finder
  def initialize(ip_address, filename = "IpToCountry.csv")
    @user_number  = IPConverter.new(ip_address).to_i
    @filename     = filename
  end

  attr_reader :user_number, :filename

  def find_country
    File.foreach(filename) do |line|
      if !line.start_with?("#")
        fields  = line.delete('"').split(",")
        from_ip = fields[0].to_i
        to_ip   = fields[1].to_i
        country = fields[4]
        if (from_ip..to_ip).include?(user_number)
          return country
        end
      end
    end
    "No available country"
  end
end

ip_address = ARGV.first
puts Finder.new(ip_address).find_country
