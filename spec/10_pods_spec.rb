#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "spec_helper"

describe Ralpha::Query do

  context "#pods" do

    it "should respond to #pods" do
      Ralpha["pi"].respond_to?(:pods).should == true
    end
    
    it "should have to #pods" do
      Ralpha["pi"].pods.size.should == 5
      Ralpha["pi"].pods.last.size.should == 3 #FIXME:
    end

  end
end

describe Ralpha::Pods do
  context "self" do
    
    it "should have states" do
      Ralpha["pi"].pods.all?{|spod| spod.respond_to?(:states)}
      Ralpha["pi"].pods.all?{|spod| spod.states.should be_a(Array)}
    end

    it "should have 5 pods" do
      Ralpha["pi"].pods.size.should == 5
    end

    it "should have subpods" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.should be_a(SubPod)}
    end
    
  end
end

describe Ralpha::SubPods do
  context "#subpods" do
    it "should respond to has_image?" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.should respond_to("has_image?")} #.last[-1].image.alt.should == "pi = cos^(-1)(-1)"
    end
    it "should respond to img?" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.should respond_to("img?")}
    end
    it "should respond to text" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.should respond_to("text")}
    end
    it "should have a text" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.text.should be_a(String)}
    end
    it "should have a title" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.title.should be_a(String)}
    end
    it "should have a pod" do
      Ralpha["pi"].pods.subpods.all?{|spod| spod.pod.should be_a(Pod)}
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
