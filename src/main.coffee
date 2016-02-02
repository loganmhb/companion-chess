statusEl = $('#status')
pgnEl = $('#pgn')
fenEl = $('#fen')
computerMoveBtn = $('#move')
newgame = $('#newgame')
game = null
board = null


onDragStart = (source, piece, position, orientation) ->
        console.log "Game turn: #{game.turn()}"
        if game.game_over() or ((game.turn() == 'w' and piece.search(/^b/) != 1) and
                              (game.turn() == 'b' and piece.search(/^w/) != 1))
          return false

onDrop = (source, target) ->
        move = game.move(from: source, to: target, promotion: 'q')
        if move == null then return 'snapback'
        updateStatus()

onSnapEnd = () -> board.position(game.fen())

updateStatus = () ->
        if (game.turn() == 'w')
          moveColor = 'White'
        else
          moveColor = 'Black'

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
        if game.turn() != playerSide then makeComputerMove()

cfg = {
  draggable: true,
  position: 'start',
  onDragStart: onDragStart,
  onDrop: onDrop,
  onSnapEnd: onSnapEnd
}

makeComputerMove = () ->
  console.log("Making computer move.")
  engine.makeBestMove(game.fen(), (move) ->
    result = game.move(move)
    board.position(game.fen())
    updateStatus()
    )

playerSide = 'w'

begin = () ->
  game = new Chess()
  board = ChessBoard('board', cfg)
  updateStatus()

newgame.click((event) ->
  playerSide = $("#sideSelector").val()
  begin())


begin()
