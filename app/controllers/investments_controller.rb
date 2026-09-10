class InvestmentsController < ApplicationController
  def create
    @campaign = Campaign.find(params[:campaign_id])
    @investment = @campaign.investments.build(investment_params.merge(investor: Current.investor))

    if @investment.save
      @campaign.refresh_status!
      @recent_investments = @campaign.investments.order(created_at: :desc).limit(10)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @campaign }
      end
    else
      @recent_investments = @campaign.investments.order(created_at: :desc).limit(10)
      respond_to do |format|
        format.html { render "campaigns/show" }
      end
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount, :idempotency_key)
  end
end
