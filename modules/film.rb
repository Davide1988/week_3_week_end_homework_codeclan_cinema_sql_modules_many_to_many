require('pry')
require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./ticket')
require_relative('./screening')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price =  options['price'].to_i
  end


  def save()
    sql = "INSERT INTO films (title,price) VALUES ($1,$2) RETURNING id"
    values = [@title, @price]
    results = SqlRunner.run(sql,values)
    id = results[0]['id']
    @id = id
  end

  def Film.delete_all()
   sql = "DELETE FROM films"
   SqlRunner.run(sql)
  end


  def show_film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    film_hash = SqlRunner.run(sql,values)
    film = film_hash.first
    return film
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM
           customers INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE tickets.film_id = $1"
    values = [@id]
    results =  SqlRunner.run(sql, values)
    customers =results.map {|customer| Customer.new(customer)}
    return customers
  end

  def count_customers_for_film()
    sql = "SELECT customers.* FROM
           customers INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE tickets.film_id = $1"
    values = [@id]
    results =  SqlRunner.run(sql, values)
    return results.count
  end

  # def Film.time_of_screenings
  #   sql = 'SELECT films.title, screenings.timing FROM
  #          screenings INNER JOIN films
  #         ON screenings.film_id = films.id'
  #   # values = [@id]
  #   array_of_movies_times = SqlRunner.run(sql)
  #   films = array_of_movies_times.map {|film| Film.new(film)}
  #   times = array_of_movies_times.map {|time| Screening.new(time)}
  #   films << times
  #   binding.pry
  #   return films.flatten
  #   # array_of_movies_times.each {|movie| return movie['title']}
  #   binding.pry
  # end

  def time_of_screening
    sql = 'SELECT screenings.timing FROM
           screenings INNER JOIN films
          ON screenings.film_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return  results[0]["timing"]
  end







end
