# frozen_string_literal: true

class LogParser
  def initialize(file_name)
    @file = File.expand_path("../../#{file_name}", __FILE__)
    return if file_exists?

    raise(StandardError)
  end

  private

  def file_exists?
    File.file?(@file)
  end
end
