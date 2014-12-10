class Goal < ActiveRecord::Base
  validates :title, :body, :privacy, :user_id, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :privacy, inclusion: {in: ["Private", "Public"]}

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

end
