require 'net/http'

class Reader
  def initialize(domain, resource, season, division)
    @domain = domain
    @resource = resource
    @division = division
    @season = season
  end

  def process
    teams = {}
    filename = "#{@season}/#{@division}"
    Net::HTTP.start(@domain) do |http|
      resp = http.get(@resource)
      open(@division, 'wb') do |file|
        file.write(resp.body)
      end
    end
    first = true
    CSV.foreach(@division) do |row|
      if first
        first =false
        next
      end
      home = row[2]
      away = row[3]
      hg = row[4]
      ag = row[5]
      next if hg.nil? or ag.nil?
      home_team = teams[home] ||= Team.new(home)
      away_team = teams[away] ||= Team.new(away)
      home_rank  = home_team.rating
      away_rank  = away_team.rating
      if hg > ag
        home_team.record_win away_rank
        away_team.record_loss home_rank

      elsif hg < ag
        home_team.record_loss away_rank
        away_team.record_win home_rank
        # away win
      else
        home_team.record_draw away_rank
        away_team.record_draw home_rank
        # draw
      end
    end

    teams.values.sort_by { |t| t.rating }.reverse
  end
end