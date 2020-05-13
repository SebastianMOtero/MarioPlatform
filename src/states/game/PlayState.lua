PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.camX = 0
	self.camY = 0
	self.level = LevelMaker.generate(100, 10)
	self.tileMap = self.level.tileMap
	self.background = math.random(3)
	self.backgroundX = 0

	self.gravityOn = true
	self.gravityAmount = 6

	self.player = Player({
		x = 0, y = 0,
		width = 16, height = 20,
		texture = 'green-alien',
		stateMachine = StateMachine {
			['idle'] = function() return PlayerIdleState(self.player) end,
			['walking'] = function() return PlayerWalkingState(self.player) end,
			['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
		},
		map = self.tileMap,
		level = self.level
	})

	self.player:changeState('falling')
end

function PlayState:update(dt)
	Timer.update(dt)

	self.level:clear()

	self.player:update(dt)
	self.level:update(dt)
	self.updateCamera()

	if self.player.x <= 0 then
		self.player.x = 0
	elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
		self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
	end
end

function PlayState:render()
	love.graphics.push()
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)

	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + VIRTUAL_WIDTH), 0)

	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + VIRTUAL_WIDTH), gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

	love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))

	self.level:render()

	self.player:render()
	love.graphics.pop()

	-- score
	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.print(tostring(self.player.score), 5, 5)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(tostring(self.player.score), 4, 4)

end

function PlayState:updateCamera()
	-- self.camX = math.max(0, math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH, self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

	-- self.backgroundX = (self.camX / 3) % VIRTUAL_WIDTH
end