require('pry')
require('pg')
require_relative('modules/customer')
require_relative('modules/film')
require_relative('modules/ticket')

Ticket.delete_all
Customer.delete_all
Film.delete_all


customer1 = Customer.new({'name' => 'Davide',  'funds' => '100'})
customer1.save
customer2 = Customer.new({'name' => 'Ola', 'funds' => '50'})
customer2.save

film1 = Film.new({'title' => 'Little miss sunshine', 'price' => '10'})
film1.save
film2 = Film.new({'title' => 'Creed 2', 'price' => '10'})
film2.save


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})

ticket1.save
ticket2.save
ticket3.save


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


customer1.customer_pay_ticket(film1)



# binding.pry
nil
