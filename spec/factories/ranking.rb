FactoryBot.define do
  factory :ranking do
    association :movie
    reserved_count { 1 }
  end
end
