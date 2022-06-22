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
end
