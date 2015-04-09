class Schedule < ActiveRecord::Base
  has_many :assignations
  has_many :terms, through: :assignations
end
