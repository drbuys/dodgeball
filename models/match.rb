require('pg')
require_relative('../db/sql_runner.rb')

class Match

attr_reader :id, :home_id, :away_id, :homescore, :awayscore

  def initialize(params)
    @id = params['id'].to_i
    @home_id = params['home_id'].to_i
    @away_id = params['away_id'].to_i
    @homescore = params['homescore'].to_i
    @awayscore = params['awayscore'].to_i
  end

  def save()
    sql = "INSERT INTO matches (home_id, away_id, homescore, awayscore) VALUES ('#{@home_id}', '#{@away_id}', '#{@homescore}', '#{@awayscore}') RETURNING *;"
    return Match.map_item(sql)
  end

  def self.all()
    sql = "SELECT * FROM matches;"
    return Match.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM matches;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE matches SET home_id = #{@home_id}, away_id = #{@away_id}, homescore = #{@homescore}, awayscore = #{@awayscore} WHERE id = #{@id};"
    return Match.map_item(sql)
  end

  def teams()
    sql = "SELECT * FROM teams WHERE teams.id = #{@id}"
    return Teams.map_items(sql)
  end

  def location
    sql = "SELECT location FROM teams WHERE teams.id = #{@home_id};"
    return Team.map_item(sql).location
  end

  def winner
    if @homescore > @awayscore
      sql = "SELECT * FROM teams WHERE teams.id = #{@home_id}"
      winner = Team.map_item(sql).name
    elsif @homescore < @awayscore
      sql = "SELECT * FROM teams WHERE teams.id = #{@away_id}"
      winner = Team.map_item(sql).name
    end
    return winner
  end

  def self.map_items(sql)
    matches = SqlRunner.run( sql )
    result = matches.map { |match| Match.new( match ) }
    return result
  end

  def self.map_item(sql)
    result = Match.map_items(sql)
    return result.first
  end

end
