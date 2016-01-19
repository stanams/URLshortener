class QuestionLikes
  def initialize(options)
    @user_id, @question_id = options.values_at('user_id', 'question_id')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    found_user = db.execute(<<-SQL)
      SELECT
        *
      FROM
        users
      WHERE
        id = #{id}
    SQL
    return nil if found_user.empty?
    new_user = Users.new(found_user.first)
  end

  def self.likers_for_question_id(question_id)
    db = QuestionsDatabase.instance
    likers = db.execute(<<-SQL)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM
        users
      JOIN question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = #{question_id}
    SQL

    likers.map { |liker| Users.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    db = QuestionsDatabase.instance
    num = db.execute(<<-SQL)
      SELECT
        COUNT(user_id) AS likes
      FROM
        question_likes
      WHERE
        question_likes.question_id = #{question_id}
    SQL
    num.first['likes']
  end

  def self.liked_questions_for_user_id(user_id)
    db = QuestionsDatabase.instance
    questions = db.execute(<<-SQL)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.author_id
      FROM
        questions
      JOIN question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = #{user_id}
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    db = QuestionsDatabase.instance
    most_liked = db.execute(<<-SQL)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.title
      ORDER BY
        COUNT(question_likes.user_id) DESC
      LIMIT
        #{n}
    SQL

    most_liked.map { |question| Question.new(question) }
  end


end
