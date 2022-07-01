class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["LOGIN"], password: ENV["PASSWORD"]
  def show
  end
end
