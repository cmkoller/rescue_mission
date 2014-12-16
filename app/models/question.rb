class Question < ActiveRecord::Base
  has_many :answers, -> { order(created_at: :desc) }

  validates :title,
    presence: true,
    length: {minimum: 40, maximum: 255}

  validates :description,
    presence: true,
    length: {minimum: 150}

end
