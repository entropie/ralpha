#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

describe Ralpha::States do
  context "self" do

    it "should have states" do
      Ralpha["pi"].pods[1].states.should_not be_empty
    end
    it "should respond_to name" do
      Ralpha["pi"].pods[1].states.first.should respond_to(:name)
    end
    it "should respond_to input" do
      Ralpha["pi"].pods[1].states.first.should respond_to(:input)
    end
    it "should respond_to query" do
      Ralpha["pi"].pods[1].states.first.should respond_to(:query)
    end
  end

  context "#query" do
    before(:each) do
      @state_query = Ralpha["pi"].pods[1].states.first.subquery
    end
    
    it "should return a new Query instance on #query" do
      #@state_query.should be_a(Query)
    end
    it "should return a new PodStateQuery instance on #query" do
      @state_query.pods.size.should == 8
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
