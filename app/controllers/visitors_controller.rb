class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    unless user_signed_in?
      render 'signin'
    end
  end
end
