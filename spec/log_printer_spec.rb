require "log_printer"

describe LogPrinter do
  let!(:visit_tracker) { instance_double(VisitTracker) }

  describe "#print_all_views" do
    it "Prints a list of one with correct name and total views" do
      allow(visit_tracker).to receive(:count).and_return(5)
      list = [["/home/test", visit_tracker]]
      expect { LogPrinter.print_all_views(list) }.to output("/home/test 5 visits\n").to_stdout
    end

    it "Correctly prints with the singular" do
      allow(visit_tracker).to receive(:count).and_return(1)
      list = [["/home/test", visit_tracker]]
      expect { LogPrinter.print_all_views(list) }.to output("/home/test 1 visit\n").to_stdout
    end

    it "Prints a list of multiple in correct order" do
      allow(visit_tracker).to receive(:count).and_return(10, 15)
      list = [["/home", visit_tracker], ["/about", visit_tracker]]
      expect { LogPrinter.print_all_views(list) }.to output("/home 10 visits\n/about 15 visits\n").to_stdout
    end
  end

  describe "#print_unique_views" do
    it "Prints a list of one with correct name and total views" do
      allow(visit_tracker).to receive(:unique_count).and_return(5)
      list = [["/home/test", visit_tracker]]
      expect { LogPrinter.print_unique_views(list) }.to output("/home/test 5 unique views\n").to_stdout
    end

    it "Correctly prints with the singular" do
      allow(visit_tracker).to receive(:unique_count).and_return(1)
      list = [["/home/test", visit_tracker]]
      expect { LogPrinter.print_unique_views(list) }.to output("/home/test 1 unique view\n").to_stdout
    end

    it "Prints a list of multiple in correct order" do
      allow(visit_tracker).to receive(:unique_count).and_return(10, 15)
      list = [["/home", visit_tracker], ["/about", visit_tracker]]
      expect { LogPrinter.print_unique_views(list) }.to output("/home 10 unique views\n/about 15 unique views\n").to_stdout
    end
  end
end