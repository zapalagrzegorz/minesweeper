## If none of its neighbors contains a bomb, then all the adjacent neighbors are also revealed. If any of the neighbors have no adjacent bombs, they too are revealed. Et cetera.

## inaczej - jeśli, którykolwiek sąsiadujący ma bombę, to nie odsłaniaj sąsiada

## dwie podstawowe operacje
### reveal
### flag - helper for user, not count into win

## UI
### * unexplored squares
### _ interior squares
### ${} number
### F flagged spot
### input choice - coordinate system with letter at the beginning ('f' / 'r')

# Hints

I think you should have a Tile class; there's a lot of information to track about a Tile (bombed? flagged? revealed?) and some helpful methods you could write (#reveal, #neighbors, #neighbor_bomb_count). I would also have a Board class.

You should separate logic pertaining to Game UI and turn-taking from the Tile/Board classes.

You'll want to pass the Board to the Tile on initialize so the Tile instance can use it to find its neighbors. But then if at some point you use p to print out a Tile instance, you'll get way more info than you need, as the data for the Board it holds will also be printed. You can fix this by overriding (defining) the inspect method in your Tile class, having it return a string that contains just the info you want (e.g. the Tiles position and bombed, flagged, etc. state). See here for more info if you need a refresher on how to do this.

If you use command line arguments and ARGV to specify the name of the save file to load, you may be surprised to find that console input is broken. This ruby-forum.com post explains how gets interacts with ARGV/ARGF.

test
