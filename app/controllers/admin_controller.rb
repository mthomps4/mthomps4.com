# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!

  # http_basic_authenticate_with name: Rails.application.credentials.admin[:user],
  #                              password: Rails.application.credentials.admin[:password]

  def index; end
end
