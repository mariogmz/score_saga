require "rails_helper"

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_email) { "mario@dev.com" }
  let(:valid_password) { "test123!" }
  let!(:user) { User.create(email: valid_email, password: valid_password) }

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "creating a new session" do
    context "when credentials are correct" do
      it "returns a successful response" do
        post :create, params: { user: { email: valid_email, password: valid_password } }
        expect(response).to have_http_status(:ok)
      end

      it "returns a token and user data" do
        post :create, params: { user: { email: valid_email, password: valid_password } }
        body = JSON.parse(response.body)
        expect(body["data"]["token"]).to be_present
        expect(body["data"]["user"]["email"]).to eq(valid_email)
      end
    end

    context "when credentials are incorrect or user does not exist" do
      it "returns an unauthorized response" do
        post :create, params: { user: { email: "unknown@dev.com", password: "wrong" } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "#respond_to_on_destroy" do
    context "when Authorization header is present" do
      before do
        request.headers["Authorization"] = "Bearer token"
      end

      context "when current user exists" do
        before(:each) do
          allow(User).to receive(:find_by).with(jti: anything).and_return(user)
        end

        it "returns a successful response" do
          delete :destroy
          expect(response).to have_http_status(:ok)
        end
      end

      context "when current user does not exist" do
        before(:each) do
          allow(User).to receive(:find_by).with(jti: anything).and_return(nil)
        end

        it "returns an unauthorized response" do
          delete :destroy
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context "when Authorization header is not present" do
      it "returns an unauthorized response" do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
