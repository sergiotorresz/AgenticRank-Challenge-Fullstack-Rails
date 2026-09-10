class Investor < ApplicationRecord
  has_many :investments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
