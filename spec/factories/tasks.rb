FactoryBot.define do
  factory :taks do
    name { 'テストを書く' }
    description { 'RSpec & Capybara & FactoryBotを準備する' }
    user
  end
end