describe User do
  let(:user) { Fabricate.build :user }
  subject { user }

  describe "validations" do
    let(:valid_emails) { %w(michalb@tests.com michal.b@tests.extensive.com) }
    let(:invalid_emails) { %w(michalb.tests.com michalb@tests@over@extensive.com michalb@tests) }
    let(:valid_student_numbers) { %w(258560 468960 012345 999999) }
    let(:invalid_student_numbers) { %w(2585AA DOBRYY Ą 9879843 21354) }

    it "validates student number's format" do
      valid_student_numbers.each { |number| should allow_value(number).for(:student_number) }
      invalid_student_numbers.each { |number| should_not allow_value(number).for(:student_number) }
    end

    it "validates email's format" do
      valid_emails.each { |email| should allow_value(email).for(:email) }
      invalid_emails.each { |email| should_not allow_value(email).for(:email) }
    end

    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :student_number }

    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :student_number }
  end

  describe "associations" do
    it { should have_many :schedules }
    it { should have_many(:user_roles) }
    it { should have_many(:roles).through(:user_roles) }
  end

  describe "#admin?" do
    subject { user.admin? }

    before do
      allow(user).to receive(:roles).and_return roles
    end

    context "when user is admin" do
      let(:roles) { [double(name: "Admin"), double(name: "Foreman")] }

      it { should be_truthy }
    end

    context "when user is not admin" do
      let(:roles) { [double(name: "Foreman")] }

      it { should be_falsey }
    end
  end
end
