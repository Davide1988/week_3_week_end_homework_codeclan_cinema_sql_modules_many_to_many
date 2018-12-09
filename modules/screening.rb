require('pry')
require_relative('../db/sql_runner')
require_relative('./film')

class Screening

  attr_reader :id
  attr_accessor :timing, :film_id, :seating

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @timing = options['timing']
    @seating = options['seating'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (timing,seating,film_id) VALUES ($1,$2,$3) RETURNING id"
    values = [@timing, @seating, @film_id]
    results = SqlRunner.run(sql,values)
    id = results[0]['id']
    @id = id
  end

  def Screening.delete_all
   sql = "DELETE FROM screenings"
   SqlRunner.run(sql)
  end

  # def self.times_for_films
  #   sql = 'SELECT films.title, screenings.timing FROM
  #          screenings INNER JOIN films
  #         ON screenings.film_id = $1'
  #   values = [@film_id]
  #   array_of_films_and_time = SqlRunner.run(sql,values)
  #   binding.pry
  #   return array_of_films_and_time
  # end




end
