statusEl = $('#status')
pgnEl = $('#pgn')
fenEl = $('#fen')
computerMoveBtn = $('#move')
newgame = $('#newgame')

updateStatus = () ->
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

updateBoard = () -> board.position(game.fen())

pieceBelongsToMovingSide = (movingSide, piece) ->
  (movingSide == 'w' and piece.search(/^b/) != 1) and
  (movingSide == 'b' and piece.search(/^w/) != 1)

cfg = {
  draggable: true,
  position: 'start',
  onDragStart: (source, piece, position, orientation) ->
    console.log "Game turn: #{game.turn()}"
    if game.game_over() or pieceBelongsToMovingSide(game.turn(), piece)
          return false

  onDrop: (source, target) ->
    move = game.move(from: source, to: target, promotion: 'q')
    return 'snapback' if move == null
    updateStatus()
    if game.turn() != playerSide then makeComputerMove()

  onSnapEnd: () -> updateBoard()
}

game = new Chess()
board = new ChessBoard('board', cfg)

makeComputerMove = () ->
  console.log("Making computer move.")
  engine.makeBestMove(game.fen(), (move) ->
    result = game.move(move)
    updateBoard()
    updateStatus()
    )

playerSide = 'w'

begin = () ->
  game.reset()
  board.orientation(if playerSide == 'w' then "white" else "black")
  updateBoard()
  updateStatus()
  makeComputerMove() if playerSide == 'b'

newgame.click((event) ->
  playerSide = $("#sideSelector").val()
  begin())
