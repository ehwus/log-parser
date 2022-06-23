# frozen_string_literal: true

require 'log_sorter'

describe LogSorter do
  let!(:visit_tracker1) { instance_double(VisitTracker) }
  let!(:visit_tracker2) { instance_double(VisitTracker) }
  let!(:visit_tracker3) { instance_double(VisitTracker) }

  before(:each) do
    allow(visit_tracker1).to receive(:count).and_return(1)
    allow(visit_tracker2).to receive(:count).and_return(2)
    allow(visit_tracker3).to receive(:count).and_return(3)
    allow(visit_tracker1).to receive(:unique_count).and_return(1)
    allow(visit_tracker2).to receive(:unique_count).and_return(2)
    allow(visit_tracker3).to receive(:unique_count).and_return(3)
  end

  it 'initializes with a Hash of VisitTrackers' do
    expect(LogSorter.new({ example_page: visit_tracker1 })).to be
  end

  it 'Sorts total views in order from the given hash' do
    log_sorter = LogSorter.new({ "one": visit_tracker1, "two": visit_tracker2, "three": visit_tracker3 })
    sorted_list = log_sorter.all_page_views_sorted

    expect(sorted_list[0][0]).to eq(:three)
    expect(sorted_list[1][0]).to eq(:two)
    expect(sorted_list[2][0]).to eq(:one)
  end

  it 'Handles a different, more complex order' do
    allow(visit_tracker1).to receive(:count).and_return(791)
    allow(visit_tracker2).to receive(:count).and_return(1999)
    allow(visit_tracker3).to receive(:count).and_return(42)

    log_sorter = LogSorter.new({ one: visit_tracker1, two: visit_tracker2, three: visit_tracker3 })
    sorted_list = log_sorter.all_page_views_sorted

    expect(sorted_list[0][0]).to eq(:two)
    expect(sorted_list[1][0]).to eq(:one)
    expect(sorted_list[2][0]).to eq(:three)
  end

  it 'Sorts unique views in order' do
    log_sorter = LogSorter.new({ one: visit_tracker1, two: visit_tracker2, three: visit_tracker3 })
    sorted_list = log_sorter.unique_page_views_sorted

    expect(sorted_list[0][0]).to eq(:three)
    expect(sorted_list[1][0]).to eq(:two)
    expect(sorted_list[2][0]).to eq(:one)
  end

  it 'Handles a slightly more complex case' do
    allow(visit_tracker1).to receive(:unique_count).and_return(555)
    allow(visit_tracker2).to receive(:unique_count).and_return(777)
    allow(visit_tracker3).to receive(:unique_count).and_return(666)

    log_sorter = LogSorter.new({ one: visit_tracker1, two: visit_tracker2, three: visit_tracker3 })
    sorted_list = log_sorter.unique_page_views_sorted

    expect(sorted_list[0][0]).to eq(:two)
    expect(sorted_list[1][0]).to eq(:three)
    expect(sorted_list[2][0]).to eq(:one)
  end
end
