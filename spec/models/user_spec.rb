describe User do
  it { should have_many :events }

  it { should validate_presence_of :name }

  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "#email" do 
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    context("with an improper email format") do

      it("should validate the format of email") do
        user = build(:user, email: "lolcats")
        user.save
        expect(user.errors.full_messages).to include("Email is invalid")
      end
    end
  end

  describe "#phone_number" do 
    context("with a communication preference that includes phone") do

      it("should validate the presence of phone_number") do
        user = build(:user, communication_preference: "all_comms")
        user.save
        expect(user.errors.full_messages).to include("Phone number can't be blank")
      end

      it("should validate the format of phone_number") do
        user = build(:user, phone_number: "21443", communication_preference: "all_comms")
        user.save
        expect(user.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end

  describe :communication_preference do
    it("should define all possibilities for communication") do 
      expect(User.communication_preferences).to include(:email, :phone, :all_comms)
    end
  end

  describe ".find_or_create_with_auth_hash" do 
    context("given an available github_id") do 
      it("should return the relevant persisted user") do
        user = create(:user, github_id:"github")
        auth_hash = { "uid" => "github" }
        expect(User.find_or_create_with_auth_hash(auth_hash)).to eq(user)
      end
    end

    context("given an available email address with no github_id") do 
      it("should return the relevant persisted user") do
        email_1 = "octocat@github.com"
        github_1 = "github"
        auth_hash = { "uid" => github_1, "info" => { "email" => email_1 } }

        expected_user = create(:user, email: email_1)
        actual_user = User.find_or_create_with_auth_hash(auth_hash)

        expect(actual_user.email).to eq(expected_user.email)
        expect(actual_user.github_id).to eq(github_1)
      end
    end

    context("with no available email or github_id") do 
      email_1 = "octocat2@github.com"
      github_1 = "github2"
      name_1 = "octocat"
      username_1 = "octoLion"

      auth_hash = { 
        "uid" => github_1, 
        "info" => { 
          "email" => email_1,
          "name" => name_1,
          "nickname" => username_1  
        } 
      }

      it("should build a new user") do
        allow(User).to receive(:build_from_auth_hash)
        actual_user = User.find_or_create_with_auth_hash(auth_hash)
        expect(User).to have_received(:build_from_auth_hash)
      end

      it("should return a new user with relevant credentials") do
        actual_user = User.find_or_create_with_auth_hash(auth_hash)
        expect(actual_user.email).to eq(email_1)
        expect(actual_user.name).to eq(name_1)
        expect(actual_user.username).to eq(username_1)
        expect(actual_user.github_id).to eq(github_1)
        expect(actual_user.persisted?).to be_falsy
      end
    end
  end
end
