require 'spec_helper'

describe User, :focus => true do
  
  before(:each) do
  	@attr = { :login => "login", :password => "password" }
  end

  it "should create a user" do
  	User.create!(@attr)
  end

  it "should require a login" do
  	user = User.new(@attr.merge(:login => ""))
  	user.should_not be_valid
  end

  it "should reject duplicate logins" do
  	User.create!(@attr)
  	second_user = User.new(@attr)
  	second_user.should_not be_valid
  end

  describe "passwords" do

  	before(:each) { @user = User.new(@attr) }

  	it "should have a password attribute" do
  		@user.should responde_to(:password)
  	end
  end

  describe "password validateions" do

  	it "should require a password" do
  		User.new({ :login => "login", :passowrd => "" }).should_not be_valid
  	end
  end

  describe "password encryption" do

  	before(:each) { @user = User.create!(@attr) }

  	it "should have an encrypted password attribute" do
  		@user.should responde_to(:encrypted_password)
  	end

  	it "should set the encrypted password attribute" do
  		@user.encrypted_password.should_not be_blank
  	end

  	it "should have a salt" do
  		@user.should responde_to(:salt)
  	end

  	describe "has_password? method" do

	  	it "should exist" do
	  		@user.should responde_to(:has_password?)
	  	end

	  	it "should return true if the password match" do
	  		@user.has_password?(@attr[:password]).should be_true
	  	end

	  	it "should return false if the passwords don't match" do
	  		@user.has_password?("invalid").should be_false
	  	end
	  end 

	  describe "authenticate method" do

	  	it "should exist" do
	  		User.should responde_to(:authenticate)
	  	end

	  	it "should return nil on login/password mismatch" do
	  		User.authenticate(@attr[:login], "wrongpass").should be_nil
	  	end

	  	it "should return nil for an login with no user" do
	  		User.authenticate("foologin", @attr[:password]).should be_nil
	  	end

	  	it "should return the user on login/password match" do
	  		User.authenticate(@attr[:login], @attr[:password]).should == @user
	  	end
	  end
  end
end
