require 'byebug'
class Users
  attr_accessor :id, :fname, :lname

  def self.all_users
    all = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL

    all.map { |user| Users.new(user) }
  end

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL)
      SELECT
        *
      FROM
        users
      WHERE
        id = #{id}
    SQL

    all.map { |user| Users.new(user) }
  end

  def self.find_by_name(fname, lname)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL)
      SELECT
        *
      FROM
        users
      WHERE
        fname = #{fname} AND lname = #{lname}
    SQL

    all.map { |user| Users.new(user) }
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Replies.find_by_reply_author_id(self.id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(self.id)
  end

  def average_karma
    db = QuestionsDatabase.instance
    db.execute(<<-SQL)
      SELECT
        CAST(COUNT(question_likes.user_id) AS FLOAT) /
        COUNT(DISTINCT(questions.title))

      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.author_id
      HAVING
        questions.author_id = #{self.id}
    SQL
  end

end
