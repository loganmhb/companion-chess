sf = new Worker('js/lib/stockfish.js')

uciEl = $("#uci")
uciHistoryEl = $("#ucihistory")

parseMove = (uciMove) ->
  move = {from: uciMove[0..1], to: uciMove[2..3]}
  console.log move
  move

parseUci = (uciMessage) ->
  [command, args...] = uciMessage.split(" ")
  switch command
    when "bestmove" then {type: "bestmove", move: parseMove(args[0])}
    when "info" then {type: "info", args: args}


postMessage = (message) ->
  uciHistoryEl.append("<br>#{message}")
  sf.postMessage(message)

postMessage = (message) ->
  uciHistoryEl.append("<br>#{message}")
  sf.postMessage(message)


receiveMessage = (message) ->
  uciHistoryEl.append("<br><span style=\"color: blue\">#{message}</span>")
  parseUci(message)

uciEl.keypress (event) ->
  if event.keyCode == 13 # enter
    postMessage(uciEl.val())
    uciEl.val("")

makeBestMove = (fen, moveHandler) ->
  console.log("Getting best move.")
  # Assign callback to make move when bestmove is received
  sf.onmessage = (event) ->
    command = receiveMessage(event.data)
    if command?.type == "bestmove"
      moveHandler(command.move)
  postMessage("position fen #{fen}")
  postMessage("go depth 8")

window.engine = {
  makeBestMove: (fen, moveHandler) ->
          makeBestMove(fen, moveHandler)
}
