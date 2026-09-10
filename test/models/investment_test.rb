require "test_helper"

class InvestmentTest < ActiveSupport::TestCase
  test "valid investment saves" do
    investment = Investment.new(
      campaign: campaigns(:torre),
      investor: investors(:ana),
      amount: 500,
      idempotency_key: SecureRandom.uuid
    )

    assert investment.save
  end

  test "rejects amount below the minimum" do
    investment = Investment.new(
      campaign: campaigns(:torre),
      investor: investors(:ana),
      amount: 100,
      idempotency_key: SecureRandom.uuid
    )

    assert_not investment.valid?
  end
end
