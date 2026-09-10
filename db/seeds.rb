# This file seeds the database with sample investors, campaigns, and
# investments so the app is immediately explorable after `docker compose up`.
# It is idempotent: re-running it (e.g. on every container boot) upserts by a
# natural key instead of piling up duplicate rows.

investors = [
  { name: "Ana Martinez", email: "ana@example.com" },
  { name: "Luis Rodriguez", email: "luis@example.com" },
  { name: "Sofia Hernandez", email: "sofia@example.com" }
].map do |attrs|
  Investor.find_or_create_by!(email: attrs[:email]) { |i| i.name = attrs[:name] }
end

campaigns = [
  {
    name: "Torre Reforma 180",
    description: "A 22-story mixed-use tower in the heart of Reforma, Mexico City.",
    product: "DEUDA",
    goal: 5_000_000,
    annual_rate_bps: 1400,
    term_months: 18,
    status: "open",
    closes_on: 60.days.from_now.to_date
  },
  {
    name: "Playa Norte Residences",
    description: "Beachfront condos in Playa del Carmen, sold as fractional co-ownership.",
    product: "COPROPIEDAD",
    goal: 3_200_000,
    annual_rate_bps: 1100,
    term_months: 24,
    status: "open",
    closes_on: 45.days.from_now.to_date
  },
  {
    name: "Distrito Roma Lofts",
    description: "Boutique loft conversion in Roma Norte, close to fully funded.",
    product: "DEUDA",
    goal: 1_500_000,
    annual_rate_bps: 1250,
    term_months: 12,
    status: "open",
    closes_on: 30.days.from_now.to_date
  }
].map do |attrs|
  Campaign.find_or_create_by!(name: attrs[:name]) do |c|
    c.assign_attributes(attrs.except(:name))
  end
end

def seed_investment!(campaign, investor, amount, seed_name)
  key = "seed-#{seed_name}"
  Investment.find_or_create_by!(idempotency_key: key) do |investment|
    investment.campaign = campaign
    investment.investor = investor
    investment.amount = amount
  end
end

torre, playa, roma = campaigns
ana, luis, sofia = investors

seed_investment!(torre, ana, 25_000, "torre-ana")
seed_investment!(torre, luis, 15_000, "torre-luis")
seed_investment!(playa, sofia, 40_000, "playa-sofia")
seed_investment!(playa, ana, 10_000, "playa-ana")
seed_investment!(roma, luis, 900_000, "roma-luis")
seed_investment!(roma, sofia, 550_000, "roma-sofia")

Campaign.find_each(&:refresh_status!)

puts "Seeded #{Investor.count} investors, #{Campaign.count} campaigns, #{Investment.count} investments."
