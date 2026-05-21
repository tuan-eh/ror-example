class Project < ApplicationRecord
  # If a project is deleted, destroy all its tasks too!
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end
