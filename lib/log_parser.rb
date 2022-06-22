# frozen_string_literal: true

require 'visit_tracker'

class LogParser
  def initialize(file_name, visit_tracker = VisitTracker)
    @pages_with_logs = {}
    @visit_tracker = visit_tracker
    @file = File.expand_path("../../#{file_name}", __FILE__)
    return if file_exists?

    raise 'Invalid file path'
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

  private

  def line_to_ip_and_page(line)
    split_line = line.split(' ')
    { page: split_line[0], ip: split_line[1] }
  end

  def file_exists?
    File.file?(@file)
  end
end
