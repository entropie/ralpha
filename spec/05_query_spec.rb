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

  context "#assumptions" do
    it "should have an assumption" do
      Ralpha["pi"].assumptions.class.should == Assumptions
    end

    it "should respond to #to_array" do
      Ralpha["pi"].assumptions.to_array.size.should == 5
      Ralpha["pi"].assumptions.to_array.should include(["NamedConstant", "a mathematical constant", "*C.pi-_*NamedConstant-"])
    end

    it "should respond to #to_hash" do
      Ralpha["pi"].assumptions.to_hash.size.should == 5
      Ralpha["pi"].assumptions.to_hash[:namedconstant].should_not == nil
    end

    it "should respond to #to_s" do
      Ralpha["pi"].assumptions.to_s.should ==
        "NamedConstant: a mathematical constant; Character: a character; MathWorld: referring to a definition; Movie: a movie; Word: a word"
    end

    it "should respond to #namedconstant" do
      Ralpha["pi"].assumptions.namedconstant
    end

    it "should not respond to #foo" do
      expect{
        Ralpha["pi"].assumptions.foo
      }.to raise_error(NoMethodError)
    end
  end


  context "#pods" do
    it "should respond to #pods" do
      Ralpha["pi"].respond_to?(:pods).should == true
    end
    
    it "should have to #pods" do
      Ralpha["pi"].pods.size.should == 5
      Ralpha["pi"].pods.last.size.should == 3 #FIXME:
    end

    it "should have images" do
      Ralpha["pi"].pods.last[-1].image.alt.should == "pi = cos^(-1)(-1)"
    end

    it "should have states" do
      Ralpha["pi"].pods.last.states
    end

    
    it "should a have nice inspect" do
      puts Ralpha["pi"]
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
