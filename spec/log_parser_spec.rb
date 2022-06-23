# frozen_string_literal: true

require 'log_parser'
require 'log_printer'

describe LogParser do
  let!(:visit_tracker) { instance_double(VisitTracker) }

  it 'Throws an error if instantiated without a file path' do
    expect { LogParser.new }.to raise_error(ArgumentError)
  end

  it 'Throws an error if instantiated with an invalid file path' do
    expect { LogParser.new('not_a_file.log') }.to raise_error(StandardError)
  end

  it 'Correctly instantiates with a valid file path' do
    expect(LogParser.new('webserver.log')).to be_truthy
  end

  describe '.process_line' do
    it 'Initialises a VisitTracker with a given IP address' do
      fake_line = '/help_page/1 126.318.035.038'
      parser = LogParser.new('webserver.log')

      allow(VisitTracker).to receive(:new)
      parser.process_line(fake_line)
      expect(VisitTracker).to have_received(:new).with('126.318.035.038')
    end

    it 'Calls log_visit on second visit' do
      fake_line = '/help_page/1 126.318.035.038'
      parser = LogParser.new('webserver.log')
      fake_logger = double

      allow(VisitTracker).to receive(:new).and_return(fake_logger)
      parser.process_line(fake_line)

      allow(fake_logger).to receive(:log_visit)
      parser.process_line(fake_line)

      expect(fake_logger).to have_received(:log_visit).with('126.318.035.038')
    end
  end

  describe '.sort' do
    it 'Initialises a LogSorter with the pages_with_logs, gets all views and unique views' do
      fake_log_sorter = double
      allow(fake_log_sorter).to receive(:all_page_views_sorted).and_return([['/test', visit_tracker]])
      allow(fake_log_sorter).to receive(:unique_page_views_sorted).and_return([['/test', visit_tracker]])
      allow(LogSorter).to receive(:new).and_return(fake_log_sorter)

      parser = LogParser.new('webserver.log')
      parser.sort

      expect(LogSorter).to have_received(:new).with({})

      expect(fake_log_sorter).to have_received(:all_page_views_sorted)
      expect(fake_log_sorter).to have_received(:unique_page_views_sorted)
    end
  end

  describe '.print_results' do
    it 'calls the printing class methods appropriately' do
      allow(LogPrinter).to receive(:print_all_views)
      allow(LogPrinter).to receive(:print_unique_views)

      parser = LogParser.new('webserver.log')

      parser.print_results

      expect(LogPrinter).to have_received(:print_all_views).with([])
      expect(LogPrinter).to have_received(:print_unique_views).with([])
    end
  end
end
