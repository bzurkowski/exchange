class Instructor < ActiveRecord::Base
  has_many :terms

  validates :name, presence: true, length: { maximum: 50 }
end
