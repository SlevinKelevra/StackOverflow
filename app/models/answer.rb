class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  scope :ordered, -> { order(best: :desc) }

  def best!
    old_best = question.answers.where(best: true)
    transaction do
      old_best.first.update!(best: false) unless old_best.empty?
      update!(best: true)
    end
  end
end
