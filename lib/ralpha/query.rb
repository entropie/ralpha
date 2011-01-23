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

  class Pods < Array
  end

  class SubPods < Array
    attr_reader :pod
    def initialize(pod)
      @pod = pod
    end
  end

  class Image < Struct.new(:src, :alt, :title, :width, :height)
    def initialize(img)
      img.each do |i|
        attr, value = i
        self.send("#{attr}=".to_sym, value)
      end
    end

    def to_html
      "<img src='#{src}' alt='#{alt}' width='#{width}' height='#{height}' title='#{title}'/>"
    end
  end

  class States < Array
  end

  class State
    attr_reader :name, :input
    def initialize(name, input)
      @name, @input = name, input
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
      if img = xml.xpath("img").first
        @image ||= Image.new(img)
      end
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

    ValuesList.each {|vl| attr_reader vl }

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
      @states = States.new
      xml.xpath("states").children.grep(Nokogiri::XML::Element).map{|state|
        @states << State.new(state["name"], state["input"])
      }
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
      pods = Pods.new
      xml.xpath("//pod").each do |pod|
        pods << Pod.new(pod["title"], pod, self)
      end
      pods
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
