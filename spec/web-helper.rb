require 'pg'
# file containing helper code for rspec tests

def setup_test_database
  connection = PG.connect(dbname: 'chittertest', password: 'qweasd')
  connection.exec("TRUNCATE twats;")
  connection.exec("TRUNCATE users;")
end

def test_date
  '29/06/1993 14:40'
end

def add_twats_to_db
  connection = PG.connect(dbname: 'chittertest', password: 'qweasd')
  testing_twats.length.times do |i|
    connection.exec("INSERT INTO twats (message, send_time) VALUES('#{testing_twats[i][:msg]}', '#{testing_twats[i][:date]}');")
  end
end

def add_users_to_db
  connection = PG.connect(dbname: 'chittertest', password: 'qweasd')
  testing_users.length.times do |i|
    connection.exec("INSERT INTO users (username, password, email, name) VALUES('#{testing_users[i][:username]}', '#{testing_users[i][:password]}', '#{testing_users[i][:email]}', '#{testing_users[i][:name]}');")
  end
end

def testing_twats
  [{ date: test_date, msg: 'Hello World! This is my first twat!' }, 
   { date: test_date, msg: ['Lorem ipsum dolor sit amet,',
   'consectetur adipiscing elit,.',
   'sed do eiusmod tempor incididunt ut labore et dolore',
   'magna aliqua. Ut enim ad minim veniam, quis nostrud',
   'exercitation ullamco laboris nisi ut aliquip ex ea',
   'commodo consequat.'].join(' ') }, 
   { date: test_date, msg: ['As a Maker So that I can stay constantly',
   'tapped in to the shouty box of Chitter I want to receive',
    'an email if I am tagged in a Peep'].join(' ') }]
end

def testing_users
  [{ username: 'JackIsCool', password: 'hello', email: 'jackthom@gmail.com', name: 'Jack' },
   { username: 'Durain24', password: '12345', email: 'Durain@gmail.com', name: 'Durain'   },
   { username: 'UserBot3000', password: 'password', email: 'robo@gmail.com', name: 'Rob'  },
   { username: 'UWotm8', password: 'password1', email: 'chav@chav.com', name: 'M8'        }
  ]
end

def login_to_twat
  visit('/')
  add_users_to_db
  fill_in('login_username', with: 'JackIsCool')
  fill_in('login_password', with: 'hello')
  click_button('Login')
end
