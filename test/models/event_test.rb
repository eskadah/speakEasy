require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test 'should create event' do
    event         = Event.new
    event.speaker = users(:one)
    event.start   = 1.day.ago
    event.end     = 2.days.from_now
    event.title   = 'Create Test Event'

    assert event.save
  end

  test 'should find event' do
    event_id = events(:past).id
    assert_nothing_raised{Event.find(event_id)}
  end

  test 'should update event' do
    event = events(:past)
    assert event.update_attributes(:title => 'new title')
  end

  test 'should destroy event' do
    event = events(:past)
    event.destroy
    assert_raise(ActiveRecord::RecordNotFound) {Event.find(event.id)}
  end


  test 'should not create an event without start time, end time and title' do
    event = Event.new
    assert !event.valid?
    assert event.errors[:start].any?
    assert event.errors[:end].any?
    assert event.errors[:title].any?
    assert_equal ["can't be blank"],event.errors[:title]
    assert_equal ["can't be blank"],event.errors[:start]
    assert_equal ["can't be blank"],event.errors[:end]
  end

  test 'should not create an event with invalid times' do
    event = Event.new(:title => 'a title',:start =>Date.today,:end => 2.days.ago)
    assert !event.valid?
  end

  test 'should build all day event' do
    event = Event.new(:title => 'a title',:start =>Date.today,:end => Date.today,:all_day => true)
    assert event.save
    assert_equal Date.today.at_beginning_of_day.to_s, Event.last.start.to_s ,'all day event start date is wrong'
    assert_equal Date.today.at_end_of_day.to_s, Event.last.end.to_s , "all day event end date is wrong #{Event.last.end}, #{Date.today.at_end_of_day}"

  end


  test 'should queue delayed job email after saving' do
    assert_difference('Delayed::Job.count', 1) do
      event = Event.new(:title => 'a title',:start =>Date.today,:end => Date.today,:all_day => true)
      event.save
    end
  end




end
