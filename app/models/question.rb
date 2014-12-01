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
    # ActiveRecord
    results = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
      .where("answer_choices.question_id = ?", self.id)

    results.map { |result| { result.choice => result.response_count } }


    # # SQL Version
    # Question.find_by_sql(<<-SQL)
    #     SELECT
    #       answer_choices.*, COUNT(responses.id) AS response_count
    #     FROM
    #       answer_choices
    #     LEFT OUTER JOIN
    #       responses
    #     ON
    #       answer_choices.id = responses.answer_choice_id
    #     WHERE
    #       answer_choices.question_id = 3
    #     GROUP BY
    #       answer_choices.id
    #   SQL

    # # Includes Version
    # counts = {}
    #
    # answers = answer_choices.includes(:responses)
    #
    # answers.each do |answer_choice|
    #   counts[answer_choice.choice] = answer_choice.responses.length
    # end
    #
    # counts

    # # N+1 Version
    # counts = {}
    # answer_choices.each do |answer|
    #   counts[answer.choice] = answer.responses.count
    # end
    # counts
  end
end
