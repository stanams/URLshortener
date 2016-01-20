require 'byebug'
class Question < SuperModel
  attr_accessor :id, :title, :body, :author_id

  def initialize(options)
    @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
  end

  def save
    if !self.id.nil?
      update
    else
      db = QuestionsDatabase.instance
      params = [self.title, self.body, self.author_id]
      db.execute(<<-SQL, *params)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL

      @id = db.last_insert_row_id
    end
  end

  def update
    db = QuestionsDatabase.instance
    params = [self.title, self.body, self.author_id]
    db.execute(<<-SQL, *params, id: id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = :id
    SQL
  end

  def self.find_by_author_id(author_id)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL, author_id: author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = :author_id
    SQL

    all.map { |question| Question.new(question) }
  end

  def author
    Users.find_by_id(self.author_id)
  end

  def replies
    Replies.find_by_question_id(self.id)
  end

  def followers
    QuestionFollows.followers_for_question(self.id)
  end

  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def likers
    QuestionLikes.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(self.id)
  end

  def self.most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end

end
