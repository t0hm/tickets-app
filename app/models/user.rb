class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: [:student, :teacher]

  has_many :tickets, inverse_of: :user
  belongs_to :classroom
  accepts_nested_attributes_for :tickets

  def position
    tickets = self.classroom.tickets.where(status: 0)
    tickets_users_ids = tickets.map { |t| t.user_id }
    pos = tickets_users_ids.find_index(self.id)
    if pos.nil?
      pos = 1
    else
      pos += 1
    end
    total = tickets.count

    "#{pos}/#{total}"
  end
end
