class Task < ApplicationRecord
  # optional: true prevents errors for the tasks you already created
  # before the Project concept existed!
  belongs_to :project, optional: true

  validates :title, presence: true

  scope :pending, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }
end
