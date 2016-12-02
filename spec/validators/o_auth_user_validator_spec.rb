require 'rails_helper'

describe OAuthUserValidator do 
  it("should validate presence of name") do 
    validator = OAuthUserValidator.new(build(:user, name: nil))
    validator.valid?
    expect(validator.errors.full_messages).to include("Name can't be blank")
  end

  it("should validate presence of username") do 
    validator = OAuthUserValidator.new(build(:user, username: nil))
    validator.valid?
    expect(validator.errors.full_messages).to include("Username can't be blank")
  end

  it("should validate presence of github_id") do 
    validator = OAuthUserValidator.new(build(:user, github_id: nil))
    validator.valid?
    expect(validator.errors.full_messages).to include("Github can't be blank")
  end


  it("should validate presence of email") do 
    validator = OAuthUserValidator.new(build(:user, email: nil))
    validator.valid?
    expect(validator.errors.full_messages).to include("Email can't be blank")
  end

  it("should validate the uniqueness of the username") do
    create(:user, username:"mcStuffins")
    validator = OAuthUserValidator.new(build(:user, username: "mcStuffins"))
    validator.valid?
    expect(validator.errors.full_messages).to include("Username has already been taken")
  end

    it("should validate the uniqueness of the email") do
    create(:user, email:"mcStuffins@goodStuff.com")
    validator = OAuthUserValidator.new(build(:user, email: "mcStuffins@goodStuff.com"))
    validator.valid?
    expect(validator.errors.full_messages).to include("Email has already been taken")
  end
end

