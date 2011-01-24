#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module Ralpha
  module Spec

    SpecDataDir = "spec/spec_data"
    
    class MockQuery < Query

      def xml
        @xml ||= Nokogiri::XML(File.readlines(File.join(SpecDataDir, "%s.xml" % query)).join)
      end
      
    end

    class MockPodStateQuery < PodStateQuery
      SpecNameToFileMapping = {
        "DecimalApproximation__More digits" => "pi_dec_approx.xml"
      }
      def xml
        file = SpecNameToFileMapping[query]
        @xml ||= Nokogiri::XML(File.readlines(File.join(SpecDataDir, file)).join)
      end
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
