require 'byebug'
class SuperModel



  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    all = db.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
      WHERE
        id = :id
    SQL

    all.map { |obj| self.new(obj) }
  end

  def self.all
    all = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
    SQL

    all.map { |obj| self.new(obj) }
  end

  private
  TABLES = {
    'Question' => 'questions',
    'Users' => 'users',
    'Replies' => 'replies'
  }
end
