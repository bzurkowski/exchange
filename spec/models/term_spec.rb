require 'rails_helper'

describe Term do
  describe "associations" do
    it { should have_many :assignations }
    it { should have_many(:schedules).through :assignations }

    it { should belong_to :subject }
    it { should belong_to :instructor }
  end

  describe "validations" do
    it { should validate_presence_of :starts_at }
    it { should validate_presence_of :ends_at }

    it { should validate_presence_of :subject }
    it { should validate_presence_of :instructor }

    it { should validate_length_of(:description).is_at_most(100) }

    it { should validate_uniqueness_of(:starts_at).scoped_to(:subject_id, :instructor_id) }

    it "validates date range correctness" do
      subject { Fabricate.build(:term, starts_at: Time.now, ends_at: Time.now - 1.hour) }

      expect(subject).to_not be_valid
    end
  end
end
