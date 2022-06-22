# frozen_string_literal: true

require 'log_sorter'

describe LogSorter do
  let!(:visit_tracker_1) { instance_double(VisitTracker) }
  let!(:visit_tracker_2) { instance_double(VisitTracker) }
  let!(:visit_tracker_3) { instance_double(VisitTracker) }

  before(:each) do
    allow(visit_tracker_1).to receive(:count).and_return(1)
    allow(visit_tracker_2).to receive(:count).and_return(2)
    allow(visit_tracker_3).to receive(:count).and_return(3)
    allow(visit_tracker_1).to receive(:unique_count).and_return(1)
    allow(visit_tracker_2).to receive(:unique_count).and_return(2)
    allow(visit_tracker_3).to receive(:unique_count).and_return(3)
  end

  it 'initializes with a Hash of VisitTrackers' do
    expect(LogSorter.new({ example_page: visit_tracker_1 })).to be
  end

  describe '.print_views' do
    it 'Prints all views in order from the given hash' do
      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect { log_sorter.print_views }.to output("three 3 visits\ntwo 2 visits\none 1 visit\n").to_stdout
    end

    it 'Handles a different, more complex order' do
      allow(visit_tracker_1).to receive(:count).and_return(791)
      allow(visit_tracker_2).to receive(:count).and_return(1999)
      allow(visit_tracker_3).to receive(:count).and_return(42)

      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect { log_sorter.print_views }.to output("two 1999 visits\none 791 visits\nthree 42 visits\n").to_stdout
    end
  end

  describe '.print_unique_views' do
    it 'Prints unique views in order' do
      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect do
        log_sorter.print_unique_views
      end.to output("three 3 unique views\ntwo 2 unique views\none 1 unique view\n").to_stdout
    end

    it 'Handles a slightly more complex case' do
      allow(visit_tracker_1).to receive(:unique_count).and_return(555)
      allow(visit_tracker_2).to receive(:unique_count).and_return(777)
      allow(visit_tracker_3).to receive(:unique_count).and_return(666)

      log_sorter = LogSorter.new({ one: visit_tracker_1, two: visit_tracker_2, three: visit_tracker_3 })

      expect do
        log_sorter.print_unique_views
      end.to output("two 777 unique views\nthree 666 unique views\none 555 unique views\n").to_stdout
    end
  end
end
