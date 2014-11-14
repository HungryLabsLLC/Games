class Player

  def initialize(player_id, match)
    @current_player = player_id
    @opposing_player = player_id == 1 ? 2 : 1
    @match = match
    @remaining_slots = @match.remaining_slots
  end

  def current_player_moves
    @current_player == 1 ? @match.moves.where(player: 1) : @match.moves.where(player: 2)
  end

  def opposing_player_moves
    @opposing_player == 1 ? @match.moves.where(player: 1) : @match.moves.where(player: 2)
  end

  def what_to_do
    if potential_winners.values.flatten.count > 1 && winning_move.present?
      return "ha! you're fucked"
    elsif potential_winners.values.flatten.count == 1 && winning_move.present?
      return "we have a winna!"
    elsif potential_losers.values.flatten.present? && losing_move.present?
      return "best offense is a good defense"
    else
      return "tri corner strategy"
    end
  end

  def winning_move
    if actual_row_winners.present?
      return actual_row_winners
    elsif actual_col_winners.present?
      return actual_col_winners
    elsif actual_diag_winners.present?
      return actual_diag_winners
    else
      return []
    end
  end

  def losing_move
    if actual_row_losers.present?
      return actual_row_losers
    elsif actual_col_losers.present?
      return actual_col_losers
    elsif actual_diag_losers.present?
      return actual_diag_losers
    else
      return []
    end
  end

  def potential_winners
    return {"row" => potential_row_winners, "col" => potential_col_winners, "diag" => potential_diag_winners}
  end

  def potential_losers
    return {"row" => potential_row_losers, "col" => potential_col_losers, "diag" => potential_diag_losers}
  end

  def actual_row_winners
    return @remaining_slots.select{|slot| slot.chars.first == potential_row_winners.first}
  end

  def actual_col_winners
    return @remaining_slots.select{|slot| slot.chars.last == potential_col_winners.first}
  end

  def actual_row_losers
    return @remaining_slots.select{|slot| slot.chars.first == potential_row_losers.first}
  end

  def actual_col_losers
    return @remaining_slots.select{|slot| slot.chars.last == potential_col_losers.first}
  end

  def actual_diag_winners
    return @remaining_slots.select{|s| s == potential_diag_winners.first}
  end

  def actual_diag_losers
    return @remaining_slots.select{|s| s == potential_diag_losers.first}
  end

  def col_moves_hash(player_moves)
    moves_by_column = player_moves.map{|m| m.value.chars.last}
    return Hash[moves_by_column.uniq.map{|col| [col, moves_by_column.count(col)]}]
  end

  def row_moves_hash(player_moves)
    moves_by_row = player_moves.map{|m| m.value.chars.first}
    return Hash[moves_by_row.uniq.map{|row| [row, moves_by_row.count(row)]}]
  end

  def potential_col_winners
    return col_moves_hash(current_player_moves).select{|col, moves| moves == 2}.present? ? col_moves_hash(current_player_moves).select{|col, moves| moves == 2}.keys : []
  end

  def potential_row_winners
    return row_moves_hash(current_player_moves).select{|col, moves| moves == 2}.present? ? row_moves_hash(current_player_moves).select{|row, moves| moves == 2}.keys : []
  end

  def potential_col_losers
    return col_moves_hash(opposing_player_moves).select{|col, moves| moves == 2}.present? ? col_moves_hash(opposing_player_moves).select{|col, moves| moves == 2}.keys : []
  end

  def potential_row_losers
    return row_moves_hash(opposing_player_moves).select{|col, moves| moves == 2}.present? ? row_moves_hash(opposing_player_moves).select{|row, moves| moves == 2}.keys : []
  end

  def potential_diag_winners
    return corner_slots.select{|d| (d-current_player_moves.map(&:value)).count == 1}.flatten.present? ? corner_slots.select{|d| (d-current_player_moves.map(&:value)).count == 1}.flatten : []
  end

  def potential_diag_losers
    return corner_slots.select{|d| (d-opposing_player_moves.map(&:value)).count == 1}.flatten.present? ? corner_slots.select{|d| (d-opposing_player_moves.map(&:value)).count == 1}.flatten : []
  end

  def corner_slots
    return @match.diagonal_slots
  end



end