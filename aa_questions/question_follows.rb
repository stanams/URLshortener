class QuestionFollows
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
    new_user = QuestionFollows.new(found_user.first)
  end

end
