require('pg')
require_relative('models/team.rb')
require_relative('models/match.rb')
require('pry-byebug')

Team.delete_all()
Match.delete_all()

team1 = Team.new({'name' => 'SuperBalls', 'location' => 'Edinburgh'})
team2 = Team.new({'name' => 'Blajhs', 'location' => 'Glasgow'})
team3 = Team.new({'name' => 'Bobbins', 'location' => 'Fife'})
team4 = Team.new({'name' => 'Sheeplovers', 'location' => 'Aberdeen'})
t1 = team1.save()
t2 = team2.save()
t3 = team3.save()
t4 = team4.save()
match1 = Match.new({'home_id' => t1.id, 'away_id' => t2.id, 'homescore' => 5, 'awayscore' => 0})
match2 = Match.new({'home_id' => t1.id, 'away_id' => t3.id, 'homescore' => 0, 'awayscore' => 6})
match3 = Match.new({'home_id' => t3.id, 'away_id' => t1.id, 'homescore' => 4, 'awayscore' => 3})
match4 = Match.new({'home_id' => t4.id, 'away_id' => t2.id, 'homescore' => 2, 'awayscore' => 9})
m1 = match1.save()
m2 = match2.save()
m3 = match3.save()
m4 = match4.save()

teams = Team.all()
matches = Match.all()

binding.pry
nil
