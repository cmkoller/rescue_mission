class Question < ActiveRecord::Base
  has_many :answers, -> { order(created_at: :desc) }
  belongs_to :user

  validates :title,
    presence: true,
    length: {minimum: 40, maximum: 255}

  validates :description,
    presence: true,
    length: {minimum: 150}

    validates :user_id,
      presence: true

end
