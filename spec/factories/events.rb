FactoryGirl.define do 
  factory :event do
    start 2.days.ago
    sequence :end do |n|
      n.days.from_now
    end
    all_day false
    title "event"
    comment "no comment for now"

    association :speaker, factory: :user, strategy: :build
  end
end
