class Admin::ApplicationController < ApplicationController

  before_filter :check_admin

  private

  def check_admin
    current_user.admin == true
  end

end
