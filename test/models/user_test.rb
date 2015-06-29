require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar");
  end
  
  test "should be valid" do
    assert @user.valid?;
  end
  
  test "name should be present" do
    @user.name = "";
    assert_not @user.valid?;
  end
  
  test "email should be present" do
    @user.email = "";
    assert_not @user.valid?;
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51;
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a"*244 + "@example.com";
    assert_not @user.valid?;
  end
  
  test "email validation should accept valid emails" do
    addresses = ["user@example.com", "USER@foo.COM", "A_US-ER@foo.bar.org", "first.last@foo.jp", "alice+bob@baz.cn" ];
    addresses.each { |email|
      @user.email = email;
      assert @user.valid?, "#{@user.email.inspect} should be valid";
    }
  end
  
  test "email validation should not accept invalid emails" do
    addresses = ["user@example,com", "user_at_foo.org", "user.name@example.", "foo@bar_baz.com", "foo@bar+baz.com"];
    addresses.each { |email|
      @user.email = email;
      assert_not @user.valid?, "{@user.email} should be invalid";
    }
  end
  
  test "emails should be unique" do
    dup_user = @user.dup;
    dup_user.email = @user.email.upcase;
    @user.save;
    assert_not dup_user.valid?;
  end
  
  test "password should be present" do
    @user.password = " " * 6;
    @user.password_confirmation = " " * 6;
    assert_not @user.valid?;
  end
  
  test " password should have a minimum length" do 
    @user.password = "a" * 5;
    @user.password_confirmation = "a" * 5;
    assert_not @user.valid?;
  end
end
