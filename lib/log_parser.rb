# frozen_string_literal: true

require 'visit_tracker'
require 'log_sorter'
require 'log_printer'

class LogParser
  def initialize(file_name)
    @pages_with_logs = {}
    @sorted_all = []
    @sorted_unique = []
    @file = File.expand_path("../../#{file_name}", __FILE__)
    return if file_exists?

    raise 'Invalid file path'
  end

  def parse
    File.readlines(@file).each { |line| process_line(line) }
  end

  def process_line(line)
    line_data = line_to_ip_and_page(line)

    page_log = @pages_with_logs[line_data[:page]]

    if page_log.nil?
      @pages_with_logs.store(line_data[:page], VisitTracker.new(line_data[:ip]))
    else
      page_log.log_visit(line_data[:ip])
    end
  end

  def sort
    log_sorter = LogSorter.new(@pages_with_logs)
    @sorted_all += log_sorter.all_page_views_sorted
    @sorted_unique += log_sorter.unique_page_views_sorted
  end

  def print_results
    LogPrinter.print_all_views(@sorted_all)
    LogPrinter.print_unique_views(@sorted_unique)
  end

  private

  def line_to_ip_and_page(line)
    split_line = line.split(' ')
    { page: split_line[0], ip: split_line[1] }
  end

  def file_exists?
    File.file?(@file)
  end
end
