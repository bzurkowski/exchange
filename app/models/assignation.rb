class Assignation < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :term

  validates :schedule, :term, presence: true

  def display_name
    decorate.display_name
  end
end
