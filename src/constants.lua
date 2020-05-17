WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

-- globl standard tile size
TILE_SIZE = 16

--width and height of scree in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

-- camera scrolling speed
CAMERA_SPEED = 100

-- speed of scrolling background
BACKGROUND_SCROLL_SPEED = 10

-- number of tiles in each tile set
TILE_SET_WIDTH = 5
TILE_SET_HEIGHT = 4

-- number of tile sets in sheet
TILE_SETS_WIDE = 6
TILE_SETS_TALL = 10

-- number of topper sets in sheet
TOPPER_SETS_WIDE = 6
TOPPER_SETS_TALL = 18

TOPPER_SETS = TOPPER_SETS_WIDE * TOPPER_SETS_TALL
TILE_SETS = TILE_SETS_WIDE * TILE_SETS_TALL

PLAYER_WALK_SPEED = 60

PLAYER_JUMP_VELOCITY = -120

SNAIL_MOVE_SPEED = 20

TILE_ID_EMPTY = 5
TILE_ID_GROUND = 3

COLLIDABLE_TILES = {
	TILE_ID_GROUND
}

BUSH_IDS = {
	1, 2, 5, 6, 7
}

COIN_IDS = {
	1, 2, 3
}

CRATES = {
	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
}

GEMS = {
	1, 2, 3, 4, 5, 6, 7, 8
}

JUMP_BLOCKS = {}

for i = 1, 30 do
	table.insert(JUMP_BLOCKS, i)
end