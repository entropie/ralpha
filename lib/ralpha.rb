#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "rubygems"
require "nokogiri"
require 'enumerator'

module Ralpha

  Source  = File.dirname(File.dirname(File.expand_path(__FILE__)))

  QueryURI = "http://api.wolframalpha.com/v1/query"
  
  $: << File.join(Source, "lib/ralpha")

  require "exceptions"
  require "query"
  require "assumptions"
  require "states"
  require "image"
  require "pods"
  require "spec"
  
  Version = [0, 0, 3]

  class << self

    attr_accessor :api_key

    attr_accessor :query_uri

    attr_accessor :spec
    
    def api_key_from_file(file)
      file = File.expand_path(file)
      raise "file not exist" unless File.exist?(file)
      self.api_key = File.readlines(file).join.strip
    end
    
    def query_uri
      @query_uri || QueryURI
    end
    
    def fetch(str)
      raise EmptyQuery if str.nil? or str.strip.empty?
      klass =
        if spec
          Spec::MockQuery
        else
          Query
        end
      klass.new(api_key, str)
    end

    alias :"[]" :fetch
    
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
