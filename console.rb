require('pry')
require('pg')
require_relative('modules/customer')
require_relative('modules/film')
require_relative('modules/ticket')
require_relative('modules/screening')


Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all


customer1 = Customer.new({'name' => 'Davide',  'funds' => '100'})
customer1.save
customer2 = Customer.new({'name' => 'Ola', 'funds' => '50'})
customer2.save
customer3 = Customer.new({'name' => 'Bob', 'funds' => '30'})
customer3.save
customer4 = Customer.new({'name' => 'Anne', 'funds' => '100'})
customer4.save
customer5 = Customer.new({'name' => 'Marc', 'funds' => '120'})
customer5.save
customer6 = Customer.new({'name' => 'Laura', 'funds' => '100'})
customer6.save


film1 = Film.new({'title' => 'Little miss sunshine', 'price' => '10'})
film1.save
film2 = Film.new({'title' => 'Creed 2', 'price' => '10'})
film2.save
film3 = Film.new({'title' => 'Fantastic beasts 2', 'price' => '10'})
film3.save

little_miss_sunshine_screening1 = Screening.new({'timing' => '20:00','seating' => '3', 'film_id' => film1.id})
creed_2_screening1 = Screening.new({'timing' => '20:30','seating' => '3', 'film_id' => film2.id})
creed_2_screening2 = Screening.new({'timing' => '21:00','seating' => '3', 'film_id' => film2.id})
fantastic_beasts_2_screening1 = Screening.new({'timing' => '21:30','seating' => '3', 'film_id' => film3.id})
little_miss_sunshine_screening1.save
creed_2_screening1.save
creed_2_screening2.save
fantastic_beasts_2_screening1.save



ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => little_miss_sunshine_screening1.id})
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id, 'screening_id' => little_miss_sunshine_screening1.id})
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id, 'screening_id' => creed_2_screening1.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => creed_2_screening2.id})
ticket5 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film2.id, 'screening_id' => creed_2_screening2.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save




# customer1.show_customer
# film1.show_film
# ticket1.show_ticket

film1.customers
customer1.films


film1.count_customers_for_film
customer1.how_many_ticket_for_customer

# customer1.funds = 200
# customer1.update
#
# film1.price = 20
# film1.update


customer1.customer_pay_ticket(film2,creed_2_screening1)
# p Film.time_of_screenings

film1.time_of_screening


#only one I couldn't do 
Ticket.most_popular_time(film2)


# binding.pry
nil
