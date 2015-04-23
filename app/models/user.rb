class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :trackable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  has_many :schedules

  validates :username, :student_number, presence: true, uniqueness: true
  validates :student_number, format: { with: /\A\d{6}\Z/, message: :format_message }
end
