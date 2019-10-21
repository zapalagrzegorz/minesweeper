
## Reveal

Start by supporting a single grid size: 9x9; randomly seed it with bombs. The user has two choices each turn:

First, they can choose a square to reveal. If it contains a bomb, game over. Otherwise, it will be revealed. If none of its neighbors contains a bomb, then all the adjacent neighbors are also revealed. If any of the neighbors have no adjacent bombs, they too are revealed. Et cetera.

The "fringe" of the revealed area is squares all adjacent to a bomb (or corner). The fringe should be revealed and contain the count of adjacent bombs.

The goal of the game is to reveal all the bomb-free squares; at this point the game ends and the player wins.
Flag bomb

## Flag bomb

The user may also flag a square as containing a bomb. A flagged square cannot be revealed unless it is unflagged first. It's possible to flag a square incorrectly, so the behavior should be the same regardless of whether there's a bomb in that square.

Flags are there to help the user keep track of bombs and do not factor into the win condition. Once every square that isn't a bomb has been revealed, the player wins regardless of whether they've flagged all the remaining squares. If none of its neighbors contains a bomb, then all the adjacent neighbors are also revealed. If any of the neighbors have no adjacent bombs, they too are revealed. Et cetera.

## User interaction
You decide how to display the current game state to the user. I recommend * for unexplored squares, _ for "interior" squares when exploring, and a one-digit number for "fringe" squares. I'd put an F for flagged spots.

You decide how the user inputs their choice. I recommend a coordinate system. Perhaps they should prefix their choice with either "r" for reveal or "f" for flag.

## Saving Games

Add save/load functionality. Use YAML to let users save/load their minesweeper game to/from a file. Be sure to use a branch for this feature.

Reference the readings on serialization.

## Hints

I think you should have a Tile class; there's a lot of information to track about a Tile (bombed? flagged? revealed?) and some helpful methods you could write (#reveal, #neighbors, #neighbor_bomb_count). I would also have a Board class.

You should separate logic pertaining to Game UI and turn-taking from the Tile/Board classes.

You'll want to pass the Board to the Tile on initialize so the Tile instance can use it to find its neighbors. But then if at some point you use p to print out a Tile instance, you'll get way more info than you need, as the data for the Board it holds will also be printed. You can fix this by overriding (defining) the inspect method in your Tile class, having it return a string that contains just the info you want (e.g. the Tiles position and bombed, flagged, etc. state). See here for more info if you need a refresher on how to do this.

If you use command line arguments and ARGV to specify the name of the save file to load, you may be surprised to find that console input is broken. This ruby-forum.com post explains how gets interacts with ARGV/ARGF.

test
