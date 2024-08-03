# frozen_string_literal: true

class Api::BaseController < ApplicationController
  before_action :authenticate_user!
end
