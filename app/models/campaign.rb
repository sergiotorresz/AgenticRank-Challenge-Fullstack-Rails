class Campaign < ApplicationRecord
  PRODUCTS = %w[DEUDA COPROPIEDAD].freeze
  STATUSES = %w[open funded closed].freeze

  has_many :investments, dependent: :destroy

  validates :name, presence: true
  validates :product, inclusion: { in: PRODUCTS }
  validates :goal, numericality: { greater_than: 0 }
  validates :annual_rate_bps, numericality: { greater_than_or_equal_to: 0 }
  validates :term_months, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: STATUSES }
  validates :closes_on, presence: true

  def raised
    investments.sum(&:amount)
  end

  def progress_pct
    return 0 if goal.zero?

    [(raised / goal * 100).round, 100].min
  end

  def projected_return(amount)
    amount * (annual_rate_bps / 10_000.0) * (term_months / 12.0)
  end

  def funded?
    raised >= goal
  end

  def refresh_status!
    update!(status: "funded") if funded? && status == "open"
  end
end
