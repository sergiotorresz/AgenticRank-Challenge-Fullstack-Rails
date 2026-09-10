class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.order(created_at: :desc)
  end

  def show
    @campaign = Campaign.find(params[:id])
    @investment = Investment.new
    @recent_investments = @campaign.investments.order(created_at: :desc).limit(10)
  end
end
