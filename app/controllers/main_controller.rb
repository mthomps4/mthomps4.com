# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @title = "MAIN"
    @contact = Contact.new()
  end
end
