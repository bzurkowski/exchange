class Subject < ActiveRecord::Base
  has_many :terms

  validates :name, presence: true, length: { maximum: 50 }

  before_create :assign_color, if: -> (subject) { subject.color.blank? }

  def assign_color
    self.color = "%06x" % (rand * 0xffffff)
  end
end
