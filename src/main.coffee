requirejs.config(
  baseUrl: "js/"
  shim: {
    'lib/chessboard-0.3.0': {
      exports: "ChessBoard",
      deps: ["jquery"]}
    }
)

requirejs(["lib/chess","board", "engine", "controlPanel"],
  (Chess, board, engine, controlPanel) ->
    game = new Chess()

    playerSide = 'w'

    uciHandler = (uciCommand) ->
      switch uciCommand.type
        when "info" then console.log("Info command received.")
        when "bestmove" then makeComputerMove(uciCommand.move)

    moveHandler = (event) ->
      switch event.type
        when "move"
          game.move(event.move)
          b.position(game.fen())
          if game.turn() != playerSide
            engine.searchForBestMove(game.fen(), uciHandler)

    cp = controlPanel(game, (side) -> playerSide = side; newGame())
    b = board(game, moveHandler)

    makeComputerMove = (move) ->
      game.move(move)
      b.position(game.fen())
      cp.updateStatus(game)

    newGame = () ->
      game.reset()
      b.orientation = (if playerSide == 'w' then "white" else "black")
      b.position(game.fen())
      cp.updateStatus(game)
      if playerSide == 'b'
        engine.searchForBestMove(game.fen(), uciHandler)

    newGame()
)
