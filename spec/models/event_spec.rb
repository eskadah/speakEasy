require "rails_helper"

describe Event do 
  it { should validate_presence_of(:start) }
  it { should validate_presence_of(:end) }
  it { should validate_presence_of(:title) }
  it { should belong_to(:speaker) } 

  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  context("with end times before start times") do
    it("should be invalid") do
      event = build(:event, start: 1.day.from_now, end: 1.day.ago)
      expect(event).to_not be_valid
    end
  end

  describe '.future_events' do
    it('should return events with start dates in the future') do
      expect(Event.future_events.to_sql).to include("start >= '#{ Date.today }'")
    end
  end

 describe '.upcoming_events' do
    it('should return 5 upcoming events for the given speaker') do
      user = create(:user)
      expect(Event.upcoming_events(user.id).to_sql).to include("(start >= '#{ Date.today }') AND \"events\".\"user_id\" = #{user.id}")
    end
  end

  describe 'send_reminder' do
    context("given a preference for email communication") do
      it("should send an email reminder") do
        user = create(:user, email: "waitingforLove@yahho.com")
        expect { user.events.create(attributes_for(:event)) }.to have_enqueued_job.on_queue("mailers")
        expect(SmsNotificationJob).to_not have_been_enqueued
      end
    end

    context("given a preference for phone communication") do
      it("should send an email reminder and a text message") do
        user = create(:user, phone_number:"1234567890", communication_preference: "all_comms")
        expect { user.events.create(attributes_for(:event)) }.to have_enqueued_job.on_queue("mailers")
        expect(SmsNotificationJob).to have_been_enqueued
      end
    end
  end
end
