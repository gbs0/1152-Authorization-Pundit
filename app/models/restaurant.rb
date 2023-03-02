class Restaurant < ApplicationRecord
  scope :all_by_user, -> (current_user) { where(user: current_user) }

  belongs_to :user
end
