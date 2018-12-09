require('pry')
require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./film')
require_relative('./screening')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id,film_id,screening_id) VALUES ($1,$2,$3) RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    results = SqlRunner.run(sql,values)
    id = results[0]['id']
    @id = id
  end

  def Ticket.delete_all
   sql = "DELETE FROM tickets"
   SqlRunner.run(sql)
  end

  def show_ticket
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [@id]
    ticket_hash = SqlRunner.run(sql,values)
    ticket = ticket_hash.first
    return ticket
  end


  def self.most_popular_time(film)
      sql =  " SELECT   screening_id
               FROM     tickets WHERE film_id = $1
               GROUP BY screening_id
               ORDER BY COUNT(*) DESC
               LIMIT    1;"
      values = [film.id]
      results = SqlRunner.run(sql,values)
      # binding.pry
      new  = results[0]

  end







end
