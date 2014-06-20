# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinata Application" do
    before do
        get '/'
    end

    it "should allow accessing the home page" do
        last_response.should be_ok
        # last_response.body.should have_content('Hello World')
    end

    it 'is successful' do
        last_response.status.should be(200)
    end
end
