#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

  class Query

    attr_accessor :query
    
    def initialize(api_key, query, opts = {})
      @query = query
    end

    def success?
      xml.xpath("//queryresult")["success"] == "true"
    end

    def assumptions
      
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
