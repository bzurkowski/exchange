require 'rails_helper'

describe Instructor do
  describe "associations" do
    it { should have_many :terms }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end
