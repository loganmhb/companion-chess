define(["jquery"], ($) ->

  uciHistoryEl = $("#ucihistory")
  sf = new Worker('js/lib/stockfish.js')

  parseMove = (uciMove) -> {from: uciMove[0..1], to: uciMove[2..3]}

  postMessage = (message) ->
    uciHistoryEl.append("<br>#{message}")
    sf.postMessage(message)

  parseMessage = (message) ->
    uciHistoryEl.append("<br><span style=\"color: blue\">#{message}</span>")
    [command, args...] = message.split(" ")
    switch command
      when "bestmove" then {type: "bestmove", move: parseMove(args[0])}
      when "info" then {type: "info", args: args}
      else {type: "ignore"}


  searchForBestMove: (fen, uciHandler) ->
    # Assign callback to make move when bestmove is received
    sf.onmessage = (event) -> uciHandler(parseMessage(event.data))
    postMessage("position fen #{fen}")
    postMessage("go depth 8")
)
