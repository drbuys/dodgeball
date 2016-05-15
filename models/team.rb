require('pg')
require_relative('../db/sql_runner.rb')

class Team

attr_reader :id, :name, :location

  def initialize(params)
    @id = params['id'].to_i
    @name = params['name']
    @location = params['location']
  end

  def save()
    sql = "INSERT INTO teams (name, location) VALUES ('#{@name}', '#{@location}') RETURNING *;"
    return Team.map_item(sql)
  end

  def self.all()
    sql = "SELECT * FROM teams;"
    return Team.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM teams;"
    SqlRunner.run(sql)
  end

  def update()
    sql ="UPDATE teams SET name = '#{@name}', location = '#{@location}' WHERE id = #{@id};"
    return Team.map_item(sql)
  end

  def home_matches()
    sql = "SELECT * FROM matches WHERE matches.home_id = #{@id}"
    return Matches.map_items(sql)
  end

  def away_matches()
    sql = "SELECT * FROM matches WHERE matches.away_id = #{@id}"
    return Matches.map_items(sql)
  end

  def all_matches()
    return home_matches.concat(away_matches)
  end

  def self.map_items(sql)
    teams = SqlRunner.run( sql )
    result = teams.map { |team| Team.new( team ) }
    return result
  end

  def self.map_item(sql)
    result = Team.map_items(sql)
    return result.first
  end


end
