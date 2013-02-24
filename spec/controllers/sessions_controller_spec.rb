require 'spec_helper'
#require 'debugger'; debugger

describe SessionsController, :focus => true do
	render_views

	describe "POST 'create'" do

		describe "failure" do

			before(:each){ @attr = { :login => "", :password => "" } }

			it "should re-render the new page" do
				xhr :post, :create, :session => @attr
				response.body.strip.should be_empty
			end

			it "should have an error message" do
				xhr :post, :create, :session => @attr
				flash.now[:error].should =~ /invalid/i
			end
		end

		describe "success" do

			before(:each) do
				@user = FactoryGirl.create(:user)
				@attr = { :login => @user.login, :password => @user.password }
			end

			it "should sign the user in" do
				xhr :post, :create, :session => @attr
				controller.current_user.should == @user
				controller.should be_signed_in
			end
		end
	end

	describe "DELETE 'destroy'" do
		it "should sign a user out" do
			test_sign_in(FactoryGirl.create(:user))
			xhr :delete, :destroy
			controller.should_not  be_signed_in
		end
	end
end
