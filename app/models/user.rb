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

  def completed_polls
    Poll.find_by_sql(<<-SQL)
      SELECT
        polls.*, COUNT(questions.id) AS count_questions
      FROM
        questions
      JOIN
        polls ON questions.poll_id = polls.id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
        SELECT
          *
        FROM
          responses
        WHERE
          responses.user_id = 1
        ) AS r ON answer_choices.id = r.answer_choice_id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(r.id)
    SQL
  end

end
