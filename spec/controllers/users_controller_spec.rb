require "rails_helper"

describe UsersController do 

  it { should use_before_action :authorized? }

  describe "nested routes" do
    it { should route(:get, "/").to(action: :new) }
    it { should route(:get, "users/events/new").to(controller: "events", action: "new") }
  end

  context "GET requests" do
    describe "#new" do
      before { get :new }

      it("should be successful") do
        expect(response).to be_successful
      end

      it("should assign locals correctly") do
        expect(assigns[:user]).to be_a(User)
        expect(assigns[:user].new_record?).to be_truthy
      end

      it { should render_template :new }
    end

    describe "#edit" do
      let(:user) { create(:user) }

      context("with an authorized user") do
        before do
          get :edit, params: { id: user.id }, session: { user_id: user.id }
        end

        it("should be successful") do
          expect(response.status).to eq(200)
        end

        it("should assign locals correctly") do
          expect(assigns[:user]).to be_a(User)
          expect(assigns[:user].new_record?).to be_falsey
        end

        it { should render_template :edit }
      end

      context("without an authorized user") do
        it("should redirect to the home page") do
          get :edit, params: { id: user.id }

          expect(response.status).to eq(302)
          expect(flash[:alert]).to eq('You need to be logged in to view this page')
          expect(response).to redirect_to :root
        end
      end
    end

    describe "#show" do
      let(:user) { create(:user) }

      context("with an authorized user") do
        before do
          get :show, params: { id: user.id }, session: { user_id: user.id }
        end

        it("should be successful") do
          expect(response).to be_successful
        end

        it("should assign locals correctly") do
          expect(assigns[:user]).to be_a(User)
          expect(assigns[:user].new_record?).to be_falsey
        end

        it { should render_template :show }
      end

      context("without an authorized user") do
        it("should redirect to the home page") do
          get :edit, params: { id: user.id }

          expect(flash[:alert]).to eq('You need to be logged in to view this page')
          expect(response).to redirect_to :root
        end
      end
    end
  end

  context "POST requests" do
    describe "#create" do
      context("with valid user credentials") do
        it "should create a new user" do
          user_params = { user: {
              name: "user_one",
              email: "user_one@onlyone.com",
              password: "insecure",
              password_confirmation: "insecure",
              username: "octocat_one",
              phone_number: "1234567890",
              communication_preference: "email",
              time_zone: "Eastern Time (US & Canada)"
            }
          }
          post :create, params: user_params
          expect(response).to redirect_to user_path(session[:user_id])
          expect(cookies[:redirect_after_error]).to be_falsey
        end
      end

      context("with invalid user credentials") do
        it "should not create a new user" do
          user_params = { user: {
              email: "user_one@onlyone.com",
              password: "insecure",
              password_confirmation: "insecure",
              username: "octocat_one",
              phone_number: "1234567890",
              communication_preference: "email",
              time_zone: "Eastern Time (US & Canada)"
            }
          }
          post :create, params: user_params
          expect(response).to render_template :new
          expect(cookies[:redirect_after_error]).to be_truthy
          expect(flash.now[:alert]).to eq("Please address the errors below")
        end
      end
    end

    describe "#update" do
      before do
       @user = create(:user)
       @id = @user.id
       session[:user_id] = @id 
     end

      context("with valid user credentials") do
        it "should update the user" do
          put(:update, params: { id: @id, user: { name: "user_one" } })
          expect(response).to redirect_to user_path(@id)
        end
      end

      context("with invalid user credentials") do
        it "should not update the user" do
          put(:update, params: { id: @id, user: { name: nil } })
          expect(response).to_not redirect_to user_path(@id)
          expect(response).to render_template :edit
        end
      end
    end
  end
end
