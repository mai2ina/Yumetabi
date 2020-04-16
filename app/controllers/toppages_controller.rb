class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to desks_url
    end
  end
end
