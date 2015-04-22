describe Role do
  describe "associations" do
    it { should have_many(:user_roles) }
    it { should have_many(:users).through(:user_roles) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end
