# frozen_string_literal: true

require './lib/log_parser'

describe LogParser do
  it 'Throws an error if instantiated without a file path' do
    expect { LogParser.new }.to raise_error(ArgumentError)
  end
end
