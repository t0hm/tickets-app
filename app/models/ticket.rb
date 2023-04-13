class Ticket < ApplicationRecord
  enum status: [:pending, :ended, :cancelled, :init]

  belongs_to :classroom
  belongs_to :user
end
