#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

  class Assumptions
    attr_accessor :xml
    
    def initialize(assumption)
      @xml = assumption
    end

    def to_array
      @array ||= @xml.xpath("//assumption").children.grep(Nokogiri::XML::Element).map { |as|
        [as["name"], as["desc"], as["input"]]
      }
    end

    def to_hash
      @hash ||= to_array.inject({}){|memo, arr|
        key, *values = arr
        memo[key.downcase.to_sym] = values
        memo
      }
    end

    def to_s
      to_array.map{|a|
        "%s: %s" % [a.first, a[1]]
      }.join("; ")
    end

    def method_missing(m, *args, &blk)
      if to_hash.include?(m)
        to_hash[m].first
      else
        super
      end
    end

    def each(&blk)
      to_array.each(&blk)
    end
    
  end
  
  class Query

    attr_accessor :query
    
    def initialize(api_key, query, opts = {})
      @query = query
    end

    def success?
      @success ||= xml.xpath("//queryresult").first["success"] == "true"
    end

    def assumptions
      @assumptions ||= Assumptions.new(xml.xpath("//assumptions"))
    end
    
  end
  
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
