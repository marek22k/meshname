
require "resolv"
require "ipaddr"
require "base32"

module Meshname
  
  # Calculates a meshname from an IPv6 address (without .meshname)
  #
  # @param ipv6 [IPAddr]
  # @return [String]
  # @example
  #   Meshname.getname IPAddr.new("215:15c:84e0:8dd5:7590:bfcd:61cf:cff7") => "aikqcxee4cg5k5mqx7gwdt6p64"
  # @example Create a .nameip domain
  #   "#{Meshname.getname IPAddr.new("215:15c:84e0:8dd5:7590:bfcd:61cf:cff7")}.meship" => "aikqcxee4cg5k5mqx7gwdt6p64.meship"
  def self.getname ipv6
    # convert IPv6 to 16 bytes
    ipv6_binary = ipv6.hton
    # encode the 16 bytes (base32)
    meshname = Base32.encode ipv6_binary
    # delete padding and convert up in down letters
    meshname.delete! "="
    meshname.downcase!
    
    return meshname
  end
  
  # Calculates an IPv6 address from a Meshname (without .meshname)
  # Links are not triggered. The mesh name is treated like a .meship domain.
  #
  # @param meshname [String]
  # @return [IPAddr]
  # @example
  #   Meshname.getip "aikqcxee4cg5k5mqx7gwdt6p64" => #<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>
  #   Meshname.getip("aikqcxee4cg5k5mqx7gwdt6p64").to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"
  def self.getip meshname
    # decode the meshname to 16 bytes
    ipv6_binary = Base32.decode meshname.upcase
    # convert the 16 bytes to a ipv6
    ipv6 = IPAddr.new_ntoh ipv6_binary
    return ipv6
  end
  
  # Resolves a .meshname or .meship domain. Links are taken into account.
  # 
  # An array of IP addresses (type: IPAddr) is always returned.
  # The reason for the array is that a name server can store several AAAA records
  # for a domain name. In order to keep the result the same,
  # an array is always returned with a .meship domain,
  # but this then only contains one entry.
  #
  # @param domain [String]
  # @return [Array] Array of IPAddr
  # @example Resolv a .meship domain
  #   Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meship") => [#<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>]
  #   Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meship")[0].to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"
  # @example Resolv a .meshname domain
  #   Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meshname") => [#<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>]
  #   Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meshname")[0].to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"
  def self.resolv domain
    parts = domain.split "."
    case parts[-1]
    when "meshname"  # case meshname
      
      # for decoding meshname remove .meshname tld
      dns_server_meshname = domain.delete_suffix ".#{parts[-1]}"
      
      # meshname to ipv6 address
      dns_server = self.getip dns_server_meshname
      
      # create DNSResolver for using custom nameserver
      dns_resolver = Resolv::DNS.new :nameserver => [dns_server.to_s]
      # request nameserver for domain (that's why also subdomains possible)
      ip = dns_resolver.getaddresses domain
      # transform Resolv::IPv6 to IPAddr
      ip.map! { |record|
        IPAddr.new_ntoh record.address
      }
      return ip
      
    when "meship"  # case meship
      return [self.getip(parts[-2])]
    end
  end
  
end
