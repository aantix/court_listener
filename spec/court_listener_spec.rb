RSpec.describe CourtListener::Search do
  let(:client) { CourtListener::Search.new('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')}

  describe "search" do
    it "searches the court listener database for a series of court cases", :vcr do
      results = client.search(q: 'traffic violation')

      expect(results["count"]).to eq(113334)
    end
  end

  describe "jurisdictions_for" do
    it "gets the codes for the specified state", :vcr do
      expect(CourtListener::Search.jurisdictions_for(state: "Nebraska")).to eq("neb nebctapp nebag")
    end

    it "returns nil for an invalid state", :vcr do
      expect(CourtListener::Search.jurisdictions_for(state: "xyz123")).to be_nil
    end
  end
end
