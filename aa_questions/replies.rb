class Replies
  attr_accessor :id, :subject_question, :parent_replay, :reply_author_id, :body

  def self.all_replies
    all = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL

    all.map { |reply| Replies.new(reply) }
  end

  def initialize(options)
    @id,
    @subject_question,
    @parent_replay,
    @reply_author_id,
    @body = options.values_at('id',
                              'subject_question',
                              'parent_replay',
                              'reply_author_id',
                              'body')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    db.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        id = #{id}
    SQL
  end

  def self.find_by_question_id(subject_question)
    db = QuestionsDatabase.instance
    db.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question = #{subject_question}
    SQL
  end

  def self.find_by_reply_author_id(reply_author_id)
    db = QuestionsDatabase.instance
    db.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_author_id = #{reply_author_id}
    SQL
  end

  def author
    Users.find_by_id(self.reply_author_id)
  end

  def question
    Question.find_by_id(self.subject_question)
  end

  def parent_reply
    Replies.find_by_id(self.parent_id)
  end

  def child_replies
    db = QuestionsDatabase.instance
    db.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply = #{self.id}
    SQL
  end


end
