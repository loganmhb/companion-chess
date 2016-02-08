define(["jquery"], ($) ->
  statusEl = $('#status')
  pgnEl = $('#pgn')
  fenEl = $('#fen')
  computerMoveBtn = $('#move')
  newgame = $('#newgame')
  sideSelector = $("#sideSelector")

  (game, newGameHandler) ->
    newgame.click((event) -> eventHandler(sideSelector.val()))
    updateStatus: (game) ->
      if (game.turn() == 'w') then moveColor = 'White' else moveColor = 'Black'
      if game.in_checkmate()
        status = 'Game over, #{moveColor} is in checkmate.'
      else if game.in_draw()
        status = 'Game over, drawn position.'
      else
        status = moveColor + ' to move.'
        if game.in_check()
          status += ' In check.'

      statusEl.html(status)
      fenEl.html(game.fen())
      console.log(game.pgn())
      pgnEl.html(game.pgn())
)
