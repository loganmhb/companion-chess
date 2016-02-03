# Chess that plays on your level

Inspired by this [post](1) on hacker news.

## Dev environment

    cake watch
    python -m SimpleHTTPServer www/index.html # web workers don't play nice with the file:// protocol

## Further reading
[The paper](2) from which I will derive the intrinsic rating system.

## Libraries

Several excellent libraries made the implementation of this much easier:
- [stockfish.js](3)
- [chessboard.js](4)
- [chess.js](5)

## TODO
- Calculate player's intrinsic rating
- Enable computer to play at intrinsic rating
- Undo button
- Save?
- Caching?
- Opening book

[1] https://news.ycombinator.com/item?id=10983317
[2] http://www.cse.buffalo.edu/~regan/papers/pdf/ReHa11c.pdf
[3] https://github.com/exoticorn/stockfish-js
[4] http://chessboardjs.com/
[5] https://github.com/jhlywa/chess.js
