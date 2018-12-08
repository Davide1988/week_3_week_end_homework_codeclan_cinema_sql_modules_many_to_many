require('pry')
require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./film')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id,film_id) VALUES ($1,$2) RETURNING id"
    values = [@customer_id, @film_id]
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

  




end
