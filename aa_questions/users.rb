class Users
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
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


end
