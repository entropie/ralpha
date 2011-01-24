#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha

  class States < Array
    attr_accessor :query
    def initialize(query)
      @query = query
      super()
    end
  end

  class State
    attr_reader :query, :name, :input
    def initialize(query, name, input)
      @query, @name, @input = query, name, input
    end

    def subquery(opts = {})
      klass =
        if Ralpha.spec
          Spec::MockPodStateQuery
        else
          PodStateQuery
        end
      klass.new(Ralpha.api_key, query, self, opts)
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
