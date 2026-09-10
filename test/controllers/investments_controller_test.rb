require "test_helper"

class InvestmentsControllerTest < ActionDispatch::IntegrationTest
  test "valid investment responds with a turbo stream" do
    campaign = campaigns(:torre)

    assert_difference "Investment.count", 1 do
      post campaign_investments_path(campaign),
           params: { investment: { amount: 600, idempotency_key: SecureRandom.uuid } },
           as: :turbo_stream
    end

    assert_equal Mime[:turbo_stream].to_s, @response.media_type
  end

  test "creating an investment increments the count" do
    campaign = campaigns(:torre)

    assert_difference "Investment.count", 1 do
      post campaign_investments_path(campaign),
           params: { investment: { amount: 750, idempotency_key: SecureRandom.uuid } }
    end
  end
end
