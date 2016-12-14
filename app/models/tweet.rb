class Tweet < ApplicationRecord
  has_many :hearts
  validates :user_name, presence: true
  validates :text, length: { maximum: 140 }, presence: true

  def not_hearted_already?(user)
    hearts.where(user: user).count == 0
  end
end
