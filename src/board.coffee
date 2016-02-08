pieceBelongsToMovingSide = (movingSide, piece) ->
  (movingSide == 'w' and piece.search(/^b/) != 1) and
  (movingSide == 'b' and piece.search(/^w/) != 1)


define(["lib/chessboard-0.3.0"], (Chessboard) ->
  (game, onMove) ->
    cfg =
      draggable: true
      position: 'start'
      onDragStart: (source, piece, position, orientation) ->
        if game.game_over() or pieceBelongsToMovingSide(game.turn(), piece)
          return false

      onDrop: (source, target) ->
        console.log("Calling onDrop")
        moveResult = onMove(
          type: "move"
          move:
            from: source
            to: target
            promotion: 'q')
        if moveResult == null or typeof moveResult == "undefined"
          return 'snapback'

      onSnapEnd: (source, target, piece) ->
        console.log("Snap ended!")

    return new ChessBoard('board', cfg)
)
