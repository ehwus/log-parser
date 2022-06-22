# frozen_string_literal: true

require 'visit_tracker'

describe VisitTracker do
  it 'instantiates with an initial IP' do
    expect(VisitTracker.new('1.1.1.1')).to be
  end

  it 'gives a count of 1 and unique count of one after initialization' do
    url_tracker = VisitTracker.new('1.1.1.1')
    expect(url_tracker.count).to be(1)
    expect(url_tracker.unique_count).to be(1)
  end

  it 'logs visit with new IP, increments uniq count & count to 2' do
    url_tracker = VisitTracker.new('1.1.1.1')
    url_tracker.log_visit('2.2.2.2')
    expect(url_tracker.count).to be(2)
    expect(url_tracker.unique_count).to be(2)
  end

  it 'logs visit with same IP, increments count to 2 leaving unique count' do
    url_tracker = VisitTracker.new('1.1.1.1')
    url_tracker.log_visit('1.1.1.1')
    expect(url_tracker.count).to be(2)
    expect(url_tracker.unique_count).to be(1)
  end
end
