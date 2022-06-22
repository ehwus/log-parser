# frozen_string_literal: true

require './lib/log_parser'

describe LogParser do
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

    xit 'Calls log_visit on second visit' do
      fake_line = '/help_page/1 126.318.035.038'
      parser = LogParser.new('webserver.log')

      allow(VisitTracker).to receive(:new)
      parser.process_line(fake_line)

      allow(VisitTracker).to receive(:log_visit)
      parser.process_line(fake_line)

      expect(VisitTracker).to have_received(:log_visit).with('126.318.035.038')
    end
  end
end
