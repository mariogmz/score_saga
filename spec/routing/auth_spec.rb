# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth", type: :routing do
  describe "routing" do
    it "routes to signup" do
      expect(post: "/api/user").to route_to("users/registrations#create", format: :json)
    end

    it "routes to login" do
      expect(post: "/api/sessions").to route_to("users/sessions#create", format: :json)
    end

    it "routes to logout" do
      expect(delete: "/api/sessions").to route_to("users/sessions#destroy", format: :json)
    end
  end
end
