class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_can_not_respond_to_own_poll

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_one :question, :through => :answer_choice, :source => :question
  has_one :poll, :through => :question, :source => :poll

  def sibling_responses
    responses_query = question.responses
    responses_query = responses_query.where("responses.id <> ?", self.id) unless self.id.nil?

    responses_query
    # questions_thing = Question
    #   .select("questions.*")
    #   .joins(answer_choices: :responses)
    #   .where("answer_choices.id = ?", self.answer_choice_id)
    #
    # responses_query = Response
    #   .select("responses.*")
    #   .joins(answer_choices: :questions)
    #   .where("questions.id = ?", questions_thing.id)

      # .joins("JOIN answer_choices AS sibling_answers ON questions.id = sibling_answers.question_id")
    #
    # responses_query = Response
    #   .select("responses.*")
    #   .joins(answer_choices: :questions)
    #   .joins("JOIN answer_choices AS sibling_answers ON questions.id = sibling_answers.question_id")

  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(["user_id = ?", self.user_id])
      errors[:already_answered] << "User has already answered this question"
    end
  end

  def author_can_not_respond_to_own_poll
    poll = Poll
      .select("polls.*")
      .joins(questions: :answer_choices)
      .where( "answer_choices.id = ?", self.answer_choice_id)


    if poll.first.author_id == self.user_id
      errors[:own_poll] << "User is trying to respond to their own poll"
    end
  end
end
