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
      @success ||= xml.xpath("//queryresult").first["success"] == "true"
    end

    def assumptions
      @assumptions ||= Assumptions.new(xml.xpath("//assumptions"))
    end

    def pods
      unless @pods
        @pods = Pods.new
        xml.xpath("//pod").each do |pod|
          pods << Pod.new(pod["title"], pod, self)
        end
      end
      @pods
    end
    
    def to_s
      str = "Query '#{query}' Success=#{success?}"
      pods.each do |pod|
        str << "\n > #{pod.title}"
        if pod.has_states?
          display_states = pod.states.map do |state|
            state.name
          end
          str << " [#{display_states.join(", ")}]"
        end
        pod.each do |spod|
          str << "\n  #{spod.to_s}"
          if spod.has_image?
            str << " {Image:true}"
          end
        end
      end
      str
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
