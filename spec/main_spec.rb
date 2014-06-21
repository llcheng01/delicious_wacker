
require File.expand_path '../spec_helper.rb', __FILE__


describe "Delicious Bookmark Application" do
    before do
        get '/api/bookmarks'
    end

    it "should allow accessing the home page" do
        last_response.should be_ok
        JSON.parse(last_response.body).should be_a_kind_of(Array)
        JSON.parse(last_response.body).length.should eq(25)
    end

end
