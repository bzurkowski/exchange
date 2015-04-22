describe UserRole do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :role }
  end

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :role }
  end
end
