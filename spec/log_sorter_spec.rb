# frozen_string_literal: true

require 'log_sorter'

describe LogSorter do
  let(:visit_tracker_1) { instance_double(VisitTracker) }
  let(:visit_tracker_2) { instance_double(VisitTracker) }
  let(:visit_tracker_3) { instance_double(VisitTracker) }

  it 'initializes with a Hash of VisitTrackers' do
    allow(visit_tracker_1).to receive(:count).and_return(1)
    expect(LogSorter.new({ example_page: visit_tracker_1 })).to be
  end

  describe '.print_views' do
    it 'Prints all views in order from the given hash' do
      allow(visit_tracker_1).to receive(:count).and_return(1)
      allow(visit_tracker_2).to receive(:count).and_return(2)
      allow(visit_tracker_3).to receive(:count).and_return(3)

      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect{ log_sorter.print_views }.to output("three 3 visits\ntwo 2 visits\none 1 visit\n").to_stdout
    end

    it 'Handles a different, more complex order' do
      allow(visit_tracker_1).to receive(:count).and_return(791)
      allow(visit_tracker_2).to receive(:count).and_return(1999)
      allow(visit_tracker_3).to receive(:count).and_return(42)

      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect{ log_sorter.print_views }.to output("two 1999 visits\none 791 visits\nthree 42 visits\n").to_stdout
    end
  end
end
