class Question < ActiveRecord::Base
  validates :body, :poll_id, :presence => true

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id
    )

  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  has_many :responses, :through => :answer_choices, :source => :responses

  def results
    counts = {}
    answer_choices.each do |answer|
      counts[answer.choice] = answer.responses.count
    end
    counts
  end
end
