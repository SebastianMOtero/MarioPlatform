PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
	self.player = player
	self.gravity = gravity
	self.animation = Animation {
		frames = {3},
		interval = 1
	}
	self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
	self.player.currentAnimation:update(dt)

	self.player.dy = self.player.dy + self.gravity
	self.player.y = self.player.y + (self.player.dy * dt)

	local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)

	local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

	if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) then 
		self.player.dy = 0

		if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
			self.player:changeState('walking')
		else
			self.player:changeState('idle')
		end

		self.player.y = (tileBottomLeft.y -1) * TILE_SIZE - self.player.height
	end
end