require 'rails_helper'

describe Schedule do
  describe "associations" do
    it { should have_many :assignations }
    it { should have_many(:terms).through :assignations }
    it { should belong_to :user }
  end
end
