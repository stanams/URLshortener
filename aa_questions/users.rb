require 'byebug'
class Users < SuperModel
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_name(fname, lname)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL, fname: fname, lname: lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = :fname AND lname = :lname
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

  def update
    db = QuestionsDatabase.instance
    params = [self.fname, self.lname]
    db.execute(<<-SQL, *params, id: id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = :id
    SQL
  end

  def average_karma
    db = QuestionsDatabase.instance
    db.execute(<<-SQL, id: id)
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
        questions.author_id = :id
    SQL
  end

end
