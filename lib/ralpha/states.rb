#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

  class States < Array
  end

  class State
    attr_reader :name, :input
    def initialize(name, input)
      @name, @input = name, input
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
