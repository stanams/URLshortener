class Replies
  attr_accessor :id, :subject_question, :parent_replay, :reply_author, :body

  def initialize(options)
    @id,
    @subject_question,
    @parent_replay,
    @reply_author,
    @body = options.values_at('id',
                              'subject_question',
                              'parent_replay',
                              'reply_author',
                              'body')
  end

  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    found_reply = db.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
      WHERE
        id = #{id}
    SQL
    return nil if found_reply.empty?
    new_reply = Replies.new(found_reply.first)
  end

end
