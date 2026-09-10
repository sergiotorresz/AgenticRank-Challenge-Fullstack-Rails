require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  test "raised sums its investments" do
    campaign = campaigns(:torre)

    assert_equal 40_000.0, campaign.raised
  end

  test "progress_pct is capped at 100" do
    campaign = campaigns(:roma)

    assert_equal 100, campaign.progress_pct
  end
end
