#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "spec_helper"

describe Query do
  context "mock" do
    it "should return a MockQuery" do
      Ralpha["pi"].class.should == Spec::MockQuery
    end
  end

  context "#xml" do
    it "should respond to #xml" do
      Ralpha["pi"].respond_to?(:xml).should == true
    end

    it "should be an instance of Nokogiri::XML" do
      Ralpha["pi"].xml.class.should == Nokogiri::XML::Document
    end

    it "should return true on success?" do
      Ralpha["pi"].success?.should == true
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
