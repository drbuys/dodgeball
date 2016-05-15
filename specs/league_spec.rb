require('minitest/autorun')
require('minitest/rg')
require_relative('../models/team.rb')
require_relative('../models/match.rb')
require_relative('../models/league.rb')

class TestLeague < MiniTest::Test

  def setup
    # Team.delete_all()
    # Match.delete_all()

    team1 = Team.new({'name' => 'SuperBalls', 'location' => 'Edinburgh'})
    team2 = Team.new({'name' => 'Blajhs', 'location' => 'Glasgow'})
    team3 = Team.new({'name' => 'Bobbins', 'location' => 'Fife'})
    team4 = Team.new({'name' => 'Sheeplovers', 'location' => 'Aberdeen'})
    @t1 = team1.save()
    @t2 = team2.save()
    @t3 = team3.save()
    @t4 = team4.save()
    match1 = Match.new({'home_id' => @t1.id, 'away_id' => @t2.id, 'homescore' => 5, 'awayscore' => 0})
    match2 = Match.new({'home_id' => @t1.id, 'away_id' => @t3.id, 'homescore' => 0, 'awayscore' => 6})
    match3 = Match.new({'home_id' => @t3.id, 'away_id' => @t1.id, 'homescore' => 4, 'awayscore' => 3})
    match4 = Match.new({'home_id' => @t4.id, 'away_id' => @t2.id, 'homescore' => 2, 'awayscore' => 9})
    @m1 = match1.save()
    @m2 = match2.save()
    @m3 = match3.save()
    @m4 = match4.save()

    # @teams = Team.all()
    # @matches = Match.all()
    @teams = [@t1, @t2, @t3, @t4]
    @matches = [@m1, @m2, @m3, @m4]
    @league = League.new(@matches, @teams)
  end

  def test_match_winners()
    result = @league.match_winners()
    assert_equal([@t1.name, @t3.name, @t3.name, @t2.name], result)
  end

  def test_total_wins()
    result = @league.total_wins(@t3)
    assert_equal([2, 'Bobbins'], result)
  end

  def test_teams_wins
    result = @league.teams_wins
    assert_equal([[1, 'SuperBalls'],[1, 'Blajhs'],[2, 'Bobbins'],[0, 'Sheeplovers']], result)
  end

  def test_league_standings
    result = @league.league_standings
    assert_equal([[2, 'Bobbins'],[1, 'Blajhs'],[1, 'SuperBalls'],[0, 'Sheeplovers']], result)
  end

end
