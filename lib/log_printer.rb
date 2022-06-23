# frozen_string_literal: true

class LogPrinter
  def self.print_all_views(visit_trackers)
    visit_trackers.each do |page|
      page_name = page[0].to_s
      view_count = page[1].count
      puts "#{page_name} #{view_count} #{correct_visit_plural(view_count)}"
    end
  end

  def self.print_unique_views(visit_trackers)
    visit_trackers.each do |page|
      page_name = page[0].to_s
      view_count = page[1].unique_count
      puts "#{page_name} #{view_count} unique #{correct_view_plural(view_count)}"
    end
  end

  def self.correct_visit_plural(number)
    number < 2 ? 'visit' : 'visits'
  end

  def self.correct_view_plural(number)
    number < 2 ? 'view' : 'views'
  end
end
