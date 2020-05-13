PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
	self.player = player
	self.animation = Animation {
		frames = {10, 11},
		interval = 0.1
	}
	self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
	self.player.currentAnimation:update(dt)
	
	if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
		self.player:changeState('idle')
	else
		local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)

		local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

		if love.keyboard.isDown('left') then
			self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
			self.player.direction = 'left'
		elseif love.keyboard.isDown('right') then
			self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
			self.player.direction = 'right'
		end
	end
end
