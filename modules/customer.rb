require('pry')
require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds =  options['funds'].to_i
  end


 def save()
   sql = "INSERT INTO customers (name,funds) VALUES ($1,$2) RETURNING id"
   values = [@name, @funds]
   results = SqlRunner.run(sql,values)
   id = results[0]['id']
   @id = id
 end

 def Customer.delete_all
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
 end

 def show_customer
   sql = "SELECT * FROM customers WHERE id = $1"
   values = [@id]
   customer_hash = SqlRunner.run(sql,values)
   customer = customer_hash.first
   return customer
 end

 def update()
   sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
   values = [@name, @funds, @id]
   SqlRunner.run(sql,values)
 end


 def films()
   sql = "SELECT films.* FROM
          films INNER JOIN tickets
          ON films.id = tickets.film_id
          WHERE tickets.customer_id = $1"
   values = [@id]
   results =  SqlRunner.run(sql, values)
   films =results.map {|film| Film.new(film)}
   return films
 end


 def how_many_ticket_for_customer()
   sql = "SELECT films.* FROM
          films INNER JOIN tickets
          ON films.id = tickets.film_id
          WHERE tickets.customer_id = $1"
   values = [@id]
   results =  SqlRunner.run(sql, values)
   return results.count
 end


 def customer_pay_ticket(film)
   if @funds >= film.price
      @funds -= film.price
   end
   update
 end


end
