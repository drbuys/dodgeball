require_relative('team.rb')
require_relative('match.rb')

class League

  attr_reader :matches, :teams

  def initialize(matches, teams)
    @matches = matches
    @teams = teams
  end

  def match_winners()
    return @matches.map { |match| match.winner}
  end

  def total_wins(team)
    wins = 0
    match_winners.each do |winner|
      if winner == team.name
        wins += 1
      end
    end
    return [wins, team.name]
  end

  def teams_wins()
    return @teams.map { |team| total_wins(team)}
  end

  def league_standings()
    return teams_wins.sort_by {|wins| wins[0] }.reverse
  end

end
