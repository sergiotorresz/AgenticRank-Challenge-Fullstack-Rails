class ApplicationController < ActionController::Base
  before_action :set_current_investor

  private

  def set_current_investor
    Current.investor = Investor.first
  end
end
