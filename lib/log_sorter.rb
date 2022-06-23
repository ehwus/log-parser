# frozen_string_literal: true

class LogSorter
  attr_accessor :all_page_views_sorted, :unique_page_views_sorted

  def initialize(visit_trackers)
    @visit_trackers = visit_trackers
    sort_data
  end

  private

  def sort_data
    @all_page_views_sorted = @visit_trackers.sort_by { |_k, v| -v.count }
    @unique_page_views_sorted = @visit_trackers.sort_by { |_k, v| -v.unique_count }
  end
end
