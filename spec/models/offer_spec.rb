describe Offer do
  describe "associations" do
    it { should belong_to :assignation }
    it { should have_many :demands }
    it { should have_many(:requested_terms).through(:demands) }
  end

  describe "validations" do
    it { should validate_presence_of :assignation }
    it { should validate_presence_of :demands }
  end
end
