// Generated by CoffeeScript 1.10.0
(function() {
  var board, cfg, computerMoveBtn, fenEl, game, makeComputerMove, onDragStart, onDrop, onSnapEnd, pgnEl, statusEl, updateStatus;

  game = new Chess();

  statusEl = $('#status');

  pgnEl = $('#pgn');

  fenEl = $('#fen');

  computerMoveBtn = $('#move');

  onDragStart = function(source, piece, position, orientation) {
    console.log("Game turn: " + (game.turn()));
    if (game.game_over() || ((game.turn() === 'w' && piece.search(/^b/) !== 1) && (game.turn() === 'b' && piece.search(/^w/) !== 1))) {
      return false;
    }
  };

  onDrop = function(source, target) {
    var move;
    move = game.move({
      from: source,
      to: target,
      promotion: 'q'
    });
    if (move === null) {
      return 'snapback';
    }
    return updateStatus();
  };

  onSnapEnd = function() {
    return board.position(game.fen());
  };

  updateStatus = function() {
    var moveColor, status;
    if (game.turn() === 'w') {
      moveColor = 'White';
    } else {
      moveColor = 'Black';
    }
    if (game.in_checkmate()) {
      status = 'Game over, #{moveColor} is in checkmate.';
    } else if (game.in_draw()) {
      status = 'Game over, drawn position.';
    } else {
      status = moveColor + ' to move.';
      if (game.in_check()) {
        status += ' In check.';
      }
    }
    statusEl.html(status);
    fenEl.html(game.fen());
    return pgnEl.html(game.pgn());
  };

  cfg = {
    draggable: true,
    position: 'start',
    onDragStart: onDragStart,
    onDrop: onDrop,
    onSnapEnd: onSnapEnd
  };

  makeComputerMove = function() {
    console.log("Making computer move.");
    return engine.makeBestMove(game.fen(), function(move) {
      var result;
      result = game.move(move);
      console.log(game.fen());
      return board.position(game.fen());
    });
  };

  computerMoveBtn.click(function(event) {
    return makeComputerMove();
  });

  board = ChessBoard('board', cfg);

  updateStatus();

}).call(this);
