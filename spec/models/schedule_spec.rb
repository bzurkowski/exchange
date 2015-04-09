require 'rails_helper'

describe Schedule do
  describe "associations" do
    it { should have_many :assignations }
    it { should have_many(:terms).through :assignations }
  end
end
