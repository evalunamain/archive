class User < ActiveRecord::Base

  validates :user_name, :presence => true, :uniqueness => true

  has_many(
    :authored_polls,
    :class_name => "Poll",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  protected
  def uncompleted_polls
    Poll
      .select("polls.*")
      .joins(questions: :answer_choices)
      .joins("LEFT OUTER JOIN (SELECT * FROM responses WHERE responses.user_id = #{id} ) AS r ON answer_choices.id = r.answer_choice_id")
      .group("polls.id")
      .having("COUNT(r.id) BETWEEN 1 AND (COUNT(distinct questions.id) - 1)")
  end

  def completed_polls
    Poll
      .select("polls.*")
      .joins(questions: :answer_choices)
      .joins("LEFT OUTER JOIN (#{ Response.where(user_id: self.id).to_sql }) AS r ON answer_choices.id = r.answer_choice_id")
      .group("polls.id")
      .having("COUNT(distinct questions.id) = COUNT(r.id)")

    # # Base SQL
    # Poll.find_by_sql(<<-SQL)
    #   SELECT
    #     polls.*
    #     -- , COUNT(questions.id) AS count_questions
    #   FROM
    #     polls
    #   JOIN
    #     questions ON questions.poll_id = polls.id
    #   JOIN
    #     answer_choices ON answer_choices.question_id = questions.id
    #   LEFT OUTER JOIN (
    #     SELECT
    #       *
    #     FROM
    #       responses
    #     WHERE
    #       responses.user_id = 2
    #     ) AS r ON answer_choices.id = r.answer_choice_id
    #   GROUP BY
    #     polls.id
    #   HAVING
    #     COUNT(DISTINCT questions.id) = COUNT(r.id)
    # SQL
  end

end
