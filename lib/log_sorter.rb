# frozen_string_literal: true

class LogSorter
  def initialize(visit_trackers)
    @visit_trackers = visit_trackers
    sort_data
  end

  def print_views
    @all_page_views_sorted.each do |page|
      page_name = page[0].to_s
      view_count = page[1].count
      puts "#{page_name} #{view_count} #{correct_visit_plural(view_count)}"
    end
  end

  def print_unique_views
    @unique_page_views_sorted.each do |page|
      page_name = page[0].to_s
      view_count = page[1].unique_count
      puts "#{page_name} #{view_count} unique #{correct_view_plural(view_count)}"
    end
  end

  private

  def sort_data
    @all_page_views_sorted = @visit_trackers.sort_by { |_k, v| -v.count }
    @unique_page_views_sorted = @visit_trackers.sort_by { |_k, v| -v.unique_count }
  end

  def correct_visit_plural(number)
    number < 2 ? 'visit' : 'visits'
  end

  def correct_view_plural(number)
    number < 2 ? "view" : "views"
  end
end
