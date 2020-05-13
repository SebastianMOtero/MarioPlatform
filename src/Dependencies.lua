--libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- entity states
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
-- require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Tile'
require 'src/TileMap'

gSounds = {
	['music'] = love.audio.newSource('sounds/music.wav', 'static')
}

gFonts = {
	['small'] = love.graphics.newFont('fonts/font.ttf', 8),
	['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
	['large'] = love.graphics.newFont('fonts/font.ttf', 32),
	['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}

gTextures = {
	['backgrounds'] = love.graphics.newImage('graphics/backgrounds.png'),
	['tiles'] = love.graphics.newImage('graphics/tiles.png'),
	['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
	['green-alien'] = love.graphics.newImage('graphics/green_alien.png')
}

gFrames = {
	['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
	['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),  
	['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),
	['green-alien'] = GenerateQuads(gTextures['green-alien'], 16, 20)
}

gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)