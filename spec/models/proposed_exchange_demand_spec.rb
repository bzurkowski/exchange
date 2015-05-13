describe ProposedExchangeDemand do
  describe "associations" do
    it { should belong_to :proposed_exchange }
    it { should belong_to :demand }
  end

  describe "fields" do
    it { should respond_to :status }
    it { should respond_to :owner }
  end

  describe "validations" do
    it { should validate_presence_of :proposed_exchange }
    it { should validate_presence_of :demand }
  end

  describe "behaviour" do
    it "initializes with status :proposed" do
      expect(subject.proposed?).to eq true
    end
  end
end
