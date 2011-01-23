#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "spec_helper"

describe Ralpha do

  context "api_key" do
    it "should respond to .api_key=" do
      Ralpha.respond_to?("api_key=").should == true
    end

    it "should be possible to set an api key" do
      Ralpha.api_key = "foobar"
    end

    it "should have an api key" do
      Ralpha.api_key.should == "foobar"
    end
  end

  context "query_uri" do
    it "should respond to .query_uri=" do
      Ralpha.respond_to?("query_uri=").should == true
    end

    it "should have an query uri" do
      Ralpha.query_uri.should == "http://api.wolframalpha.com/v1/query"
    end

    it "should be possible to set a query uri" do
      (Ralpha.query_uri = "foobar").should == "foobar"
    end

    it "should have a custom query uri" do
      Ralpha.query_uri.should == "foobar"
    end

    it "should be read an api key from a file" do
      File.open("spec/ralpha_api.txt", 'w+'){|tf| tf.puts "kekelala" }
      Ralpha.api_key_from_file("spec/ralpha_api.txt")
      Ralpha.api_key.should == "kekelala"
      File.unlink("spec/ralpha_api.txt")
    end

  end

  context "#[]" do
    it "should respond to #[]" do
      Ralpha.respond_to?("[]").should == true
    end

    it "should raise on nil query" do
      expect{
        Ralpha[nil]
      }.to raise_error(EmptyQuery)
    end

    it "should raise on empty query" do
      expect{
        Ralpha["  "]
      }.to raise_error(EmptyQuery)
    end

    it "should return a Query" do
      Ralpha.spec = false
      Ralpha["foo"].class.should == Query
      Ralpha.spec = true      
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
