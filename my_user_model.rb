
require 'sqlite3'

class User
  attr_accessor :id, :firstname, :lastname, :age, :password, :email

  def initialize(id = nil, firstname = nil, lastname = nil, age = nil, password = nil, email = nil)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @age = age
    @password = password
    @email = email
  end

  def self.connect
    db = SQLite3::Database.new('db.sql')
    db.results_as_hash = true
    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
    db
  end

  def self.create(user_info)
    db = connect
    db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)",
               [user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]])
    
    new_id = db.last_insert_row_id
    find(new_id)
  end

  def self.find(user_id)
    db = connect
    row = db.execute("SELECT * FROM users WHERE id = ?", [user_id]).first
    return nil if row.nil?

    User.new(row['id'], row['firstname'], row['lastname'], row['age'], row['password'], row['email'])
  end

  def self.all
    db = connect
    rows = db.execute("SELECT * FROM users")

    rows.map do |row|
      User.new(row['id'], row['firstname'], row['lastname'], row['age'], row['password'], row['email'])
    end
  end

  def self.update(user_id, attribute, value)
    db = connect
    db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", [value, user_id])
    find(user_id)
  end

  def self.destroy(user_id)
    db = connect
    db.execute("DELETE FROM users WHERE id = ?", [user_id])
  end
end