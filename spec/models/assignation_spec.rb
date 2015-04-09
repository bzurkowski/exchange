require 'rails_helper'

describe Assignation do
  describe "associations" do
    it { should belong_to :schedule }
    it { should belong_to :term }
  end

  describe "validations" do
    it { should validate_presence_of :schedule }
    it { should validate_presence_of :term }
  end
end
