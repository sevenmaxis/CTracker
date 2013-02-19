require 'spec_helper'

describe "LayoutLinks" do

	it "should have a page at '/'" do
		get '/'
		response.should have_selector('title', :content => "CurrencyTracker")
	end

	describe "when not signed in" do
		
		it "should have a signin link" do
			visit root_path
			response.should have_selector("a", :href => signin_path,
																				 :content => "Sign in")
			response.should have_selector("a", :href => signup_path,
																				 :content => "Sign up")
		end

		it "should not have Currencies" do
			visit root_path
			response.should_not have_selector("h1", :content => "Currencies")
			response.should_not have_selector('div.simple_pie_chart')
		end

		it "should not have Countries" do
			visit root_path
			response.should_not have_selector("h1", :content => "Countries")
			response.should_not have_selector('div.simple_pie_chart')
		end
	end

	describe "when signed in" do

		before(:each) do
			@user = Factory(:user)
			visit root_path
			fill_in :login, :with => @user.login
			fill_in :password, :with => @user.password
			click_button
		end

		it "should have a signout link" do
			visit root_path
			response.should have_selector("a", :href => signout_path,
																				 :content => "Sign out")
		end
	end
end