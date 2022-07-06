require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a User if all of the validations are true' do
    @user = User.new(first_name: "test", last_name: "test1", email: "test@test.com", password: "ABC", password_confirmation: "ABC")
    @user.valid?
    expect(@user.errors).not_to include("can\'t be blank")
    end
    it 'should not create a User if their last name is missing' do
    @user = User.new(first_name: "test", email: "test@test.com", password: "ABCDEF", password_confirmation: "ABCDEF")
    @user.valid?
    expect(@user.errors[:last_name]).to include("can\'t be blank")
    end
    it 'should not create a User if their first name is missing' do
    @user = User.new(last_name: "test1", email: "test@test.com", password: "ABCDEF", password_confirmation: "ABCDEF")
    @user.valid?
    expect(@user.errors[:first_name]).to include("can\'t be blank")
    end
    it 'should not create a User if their email is missing' do
    @user = User.new(last_name: "test1", first_name: "test", password: "ABCDEF", password_confirmation: "ABCDEF")
    @user.valid?
    expect(@user.errors[:email]).to include("can\'t be blank")
    end
    it 'should not create a User if their email is not unique' do
    @user1 = User.new(first_name: "test", last_name: "test1", email: "test@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
    @user1.save
    @user2 = User.new(first_name: "test2", last_name: "test3", email: "test@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
    @user2.valid?
    expect(@user2.errors[:email]).to include("has already been taken")
    end
    it 'should not create a User if their passwords do not match' do
    @user = User.new(first_name: "test", last_name: "test1", email: "test@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEFG")
    @user.valid?
    expect(@user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end
    it 'should not create a User if there is no password' do
    @user = User.new(first_name: "test", last_name: "test1", email: "test@gmail.com")
    @user.valid?
    expect(@user.errors[:password_digest]).to include("can\'t be blank")
    end
    it 'should not create a User if there the password is too short' do
    @user = User.new(first_name: "test", last_name: "test1", email: "test@gmail.com", password: "ABC", password_confirmation: "ABC")
    @user.valid?
    expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should log the user in if the credentials are correct' do
      @user = User.new(first_name: "test", last_name: "test1", email: "test123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("test123@gmail.com", "ABCDEF")).to be_present
    end
    it 'should not log the user in if the email is wrong' do
      @user = User.new(first_name: "test", last_name: "test1", email: "test123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("test1234@gmail.com", "ABCDEF")).not_to be_present
    end
    it 'should not log the user in if the password is wrong' do
      @user = User.new(first_name: "test", last_name: "test1", email: "test123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("test123@gmail.com", "ABCDEFG")).not_to be_present
    end
    it 'should log the user in even if the email contains spaces' do
      @user = User.new(first_name: "test", last_name: "test1", email: "test1234@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("  test1234@gmail.com   ", "ABCDEF")).to be_present
    end
    it 'should log the user in even if the email is typed with a different case' do
      @user = User.new(first_name: "test", last_name: "test1", email: "test1234@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("  teST1234@gmail.com   ", "ABCDEF")).to be_present
    end
  end
end
