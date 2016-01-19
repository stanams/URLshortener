require 'byebug'
class Question
  attr_accessor :id, :title, :body, :author_id

  def self.all_questions
    all = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
    SQL

    all.map { |question| Question.new(question) }
  end

  def initialize(options)
    @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        id = #{id}
    SQL

    all.map { |question| Question.new(question) }
  end

  def self.find_by_author_id(author_id)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = #{author_id}
    SQL

    all.map { |question| Question.new(question) }
  end

  def author
    Users.find_by_id(self.author_id)
  end

  def replies
    Replies.find_by_question_id(self.id)
  end

end
