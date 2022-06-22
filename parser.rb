# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'log_parser'

def main
  parser = LogParser.new(ARGV[0])
  parser.parse
  parser.print_results
end

main
