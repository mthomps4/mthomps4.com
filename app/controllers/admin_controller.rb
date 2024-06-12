# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin_meta_tags

  def index; end

  def set_admin_meta_tags
    set_meta_tags noindex: true, nofollow: true
  end
end
