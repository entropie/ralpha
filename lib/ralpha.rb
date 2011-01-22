#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "rubygems"
require "nokogiri"



module Ralpha

  Source  = File.dirname(File.dirname(File.expand_path(__FILE__)))

  $: << File.join(Source, "lib/ralpha")
  
  Version = [0, 0, 1]

  def self.api_key=(api)
    @api = api
  end

  class << self

    def fetch(str)
      str
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
