class Question
  attr_accessor :id, :title, :body, :author_id

  def initialize(options)
    @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    found_question = db.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        id = #{id}
    SQL
    return nil if found_question.empty?
    new_question = Question.new(found_question.first)
  end

  def self.find_by_author_id(author_id)
    db = QuestionsDatabase.instance
    found_question = db.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = #{author_id}
    SQL
    return nil if found_question.empty?
    new_question = Question.new(found_question.first)
  end


end
