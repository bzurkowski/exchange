describe Demand do
  describe "associations" do
    it { should belong_to :offer }
    it { should belong_to :term }
  end

  describe "validations" do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :term }
  end
end
