class QuestionLikes
  def initialize(options)
    @user_id, @question_id = options.values_at('user_id', 'question_id')
  end


  def self.likers_for_question_id(question_id)
    db = QuestionsDatabase.instance
    likers = db.execute(<<-SQL, question_id: question_id)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM
        users
      JOIN question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = :question_id
    SQL

    likers.map { |liker| Users.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    db = QuestionsDatabase.instance
    num = db.execute(<<-SQL, question_id: question_id)
      SELECT
        COUNT(user_id) AS likes
      FROM
        question_likes
      WHERE
        question_likes.question_id = :question_id
    SQL
    num.first['likes']
  end

  def self.liked_questions_for_user_id(user_id)
    db = QuestionsDatabase.instance
    questions = db.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.author_id
      FROM
        questions
      JOIN question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = :user_id
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    db = QuestionsDatabase.instance
    most_liked = db.execute(<<-SQL, n: n)
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
        :n
    SQL

    most_liked.map { |question| Question.new(question) }
  end


end
