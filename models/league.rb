require_relative('team.rb')
require_relative('match.rb')

class League

  attr_reader :matches, :teams

  def initialize(matches, teams)
    @matches = matches
    @teams = teams
  end

# Returns the winner of each match in the league
  def match_winners()
    return @matches.map { |match| match.winner}
  end

#Returns an array of the total wins for oneteam, along with the team name.
  def total_wins(team)
    wins = 0
    match_winners.each do |winner|
      if winner == team.name
        wins += 1
      end
    end
    return [wins, team.name]
  end

# Returns an array of each team in the league and their number of games won
  def teams_wins()
    return @teams.map { |team| total_wins(team)}
  end

# Returns an array of the current league standings (team name and games won), starting at the top of the league
  def league_standings()
    return teams_wins.sort_by {|wins| wins[0] }.reverse
  end

end
