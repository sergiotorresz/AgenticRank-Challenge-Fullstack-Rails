require "test_helper"

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  test "index renders" do
    get root_path

    assert_response :success
    assert_includes @response.body, campaigns(:torre).name
  end

  test "show renders" do
    campaign = campaigns(:torre)

    get campaign_path(campaign)

    assert_response :success
    assert_includes @response.body, "campaign_#{campaign.id}_progress"
    assert_select "form"
  end
end
