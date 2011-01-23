#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

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
  
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
