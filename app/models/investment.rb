class Investment < ApplicationRecord
  MIN_AMOUNT = 500

  belongs_to :campaign
  belongs_to :investor

  validates :amount, numericality: { greater_than_or_equal_to: MIN_AMOUNT }
  validates :idempotency_key, presence: true
end
