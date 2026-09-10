module MoneyHelper
  # Formats a peso amount (as stored on the shipped models) as "$1,234.00 MXN".
  def format_money(amount)
    number_to_currency(amount, unit: "$", precision: 2, format: "%u%n MXN")
  end
end
