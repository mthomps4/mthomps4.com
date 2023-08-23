module Admin
  class LearningsController < ApplicationController
    http_basic_authenticate_with name: 'test', password: 'secret'
    def index; end
  end
end
