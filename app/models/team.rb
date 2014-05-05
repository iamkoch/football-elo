class Team
  attr_reader :rating
  attr_reader :name

  def initialize(name)
    @name = name
    @rating = 0
    @games_played = 0
    @wins = 0
    @losses = 0
    @opp_ranks = 0
  end

  def record_win(opp_rank)
    @wins += 1
    @opp_ranks += opp_rank
    increment_games_played
    calc_rating
  end

  def calc_rating
    @rating = (@opp_ranks + 400 * (@wins - @losses)) / @games_played
  end

  def record_loss(opp_rank)
    @losses += 1
    @opp_ranks += opp_rank
    increment_games_played
    calc_rating
  end

  def record_draw(opp_rank)
    @opp_ranks += opp_rank
    increment_games_played
    calc_rating
  end

  def increment_games_played
    @games_played += 1
  end


end