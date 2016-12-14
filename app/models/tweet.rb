class Tweet < ApplicationRecord
  has_many :votes
  validates :user_name, presence: true
  validates :text, length: { maximum: 140 }, presence: true

  def not_voted_already?(user)
    votes.where(user: user).count == 0
  end
end
