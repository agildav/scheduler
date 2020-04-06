RSpec.describe Scheduler do
  before do
    # Seed database
    File.read(example_file).each_line do |line|
      id, quantity, last_update = line.split(",")
      Show.create!(id: id, quantity: quantity, last_update: last_update)
    end
  end

  describe "example 1", vcr: { cassette_name: "example1" } do
    let(:example_file) { "spec/fixtures/example1.txt" }
    let(:needs_updating) { [1, 2] }

    it "finds the IDs that need updating" do
      result = Scheduler.get_shows # replace this with your result
      ids = result.map { |k,v| k.to_i }
      expect(ids).to eq needs_updating
    end

    it "creates the update schedule" do
      scheduled = Scheduler.get_shows # replace this with your schedule
      expect(scheduled).to eq({1 => 0, 2 => 15}) # replace this hash with the correct schedule
    end
  end

  describe "example 2", vcr: { cassette_name: "example2" } do
    let(:example_file) { "spec/fixtures/example2.txt" }
    let(:needs_updating) { [2, 4] }

    it "finds the IDs that need updating" do
      result = Scheduler.get_shows # replace this with your result
      ids = result.map { |k,v| k.to_i }
      expect(ids).to eq needs_updating
    end

    it "creates the update schedule" do
      scheduled = Scheduler.get_shows # replace this with your schedule
      expect(scheduled).to eq({2 => 0, 4 => 15}) # replace this hash with the correct schedule
    end
  end

  describe "example 3", vcr: { cassette_name: "example3" } do
    let(:example_file) { "spec/fixtures/example3.txt" }
    # These are the show IDs that need updating
    let(:needs_updating) { File.read("spec/fixtures/example3-updates.txt").split.map(&:to_i) }

    it "finds the IDs that need updating" do
      result = Scheduler.get_shows # replace this with your result
      ids = result.map { |k,v| k.to_i }
      expect(ids).to eq needs_updating
    end

    it "creates the update schedule"
  end
end
