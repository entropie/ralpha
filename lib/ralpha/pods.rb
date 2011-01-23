#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

  class Pods < Array
    attr_reader :query

    def subpods
      self.map{|pod| pod.subpods }.flatten
    end
    
    def initialize(query)
      @query = query
      super()
    end
  end

  class SubPods < Array
    attr_reader :pod

    def initialize(pod)
      @pod = pod
      super()
    end
  end
  
  class SubPod
    attr_reader :title, :text, :pod, :xml

    def initialize(title, xml, ppod)
      @pod = ppod
      @title = title
      @xml = xml
      @text  = xml.xpath("plaintext").text
    end

    def inspect
      "<Subpod @parent='#{pod.title}' @title='#{title}' '#{text}'>"
    end

    def image
      unless @image
        if img = xml.xpath("img").first
          @image ||= Image.new(img)
        end
      end
      @image
    end

    def has_image?
      not image.nil?
    end
    alias :"img?" :"has_image?"

    def to_s
      "#{title}: #{text}"
    end

  end
  
  class Pod

    include Enumerable
    
    ValuesList = :title, :position, :scanner, :position, :error

    attr_reader *ValuesList

    attr_reader :xml, :query

    def subpods
      @subpods ||= SubPods.new(self)
    end
    
    def initialize(title, xml, query)
      @title = title
      @query = query
      @xml = xml
      xml.xpath("subpod").each do |spod|
        subpods << SubPod.new(spod["title"], spod, self)
      end
    end

    def inspect
      "<Pod Query='#{query.query}' Title='#{title}' Subpods=#{size}>"
    end

    def states
      unless @states
        @states = States.new
        xml.xpath("states").children.grep(Nokogiri::XML::Element).map{|state|
          @states << State.new(state["name"], state["input"])
        }
      end
      @states
    end

    def has_states?
      not states.empty?
    end
    
    def each(&blk)
      subpods.each(&blk)
    end

    def size
      subpods.size
    end
    alias :length :size

    def [](int)
      subpods[int]
    end

    def last
      subpods.last
    end

    def first
      subpods.first
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
