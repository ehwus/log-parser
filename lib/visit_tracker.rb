# frozen_string_literal: true

class VisitTracker
  attr_reader :count, :unique_count

  def initialize(initial_ip)
    @count = 1
    @unique_count = 1
    @seen_ips = { initial_ip => true }
  end

  def log_visit(ip)
    @count += 1

    return if @seen_ips.key?(ip)

    @seen_ips.store(ip, true)
    @unique_count += 1
  end
end
