require 'byebug'
class SuperModel

  def save
    if !self.id.nil?
      update
    else
      db = QuestionsDatabase.instance
      params = self.instance_variables.drop(1)
      vars = params.map { |var| self.instance_variable_get(var) }
      inserts = params.map { |sym| sym[1..-1].to_s }.join(", ")
      ques = ("?, " * vars.length)[0...-2]
      debugger
      db.execute(<<-SQL, *vars)
        INSERT INTO
          #{TABLES[self.class.to_s]} (#{inserts})
        VALUES
          (#{ques})
      SQL

      @id = db.last_insert_row_id
    end
  end

  def update
    db = QuestionsDatabase.instance

    params = self.instance_variables.drop(1)
    vars = params.map { |var| self.instance_variable_get(var) }
    inserts = params.map { |sym| sym[1..-1].to_s + " = ?"}.join(", ")

    db.execute(<<-SQL, *vars, id: id)
      UPDATE
        #{TABLES[self.class.to_s]}
      SET
        #{inserts}
      WHERE
        id = :id
    SQL
  end


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
