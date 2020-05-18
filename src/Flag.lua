Flag = Class{__includes = Entity}

function Flag:init(def)
	Entity.init(self, def)
	self.flag = def.flag
	self.flagpole = def.flagpole
	self.animation = Animation {
		frames = {1, 2, 3},
		interval = 0.2
	}
	self.x = def.x
	self.y = def.y
	self.currentAnimation = self.animation
end

function Flag:update(dt)
	self.currentAnimation:update(dt)
end

function Flag:render()
	love.graphics.draw(gTextures['flag'], gFrames['flagpole'][self.flagpole], math.floor(self.x), math.floor(self.y), 0, 1, 1, 0, 0)
	love.graphics.draw(gTextures['flag'], gFrames['flagFlying'][self.flag][self.currentAnimation:getCurrentFrame()], math.floor(self.x), math.floor(self.y), 0, 1, 1, -8, 0)
	-- love.graphics.draw(gTextures['flag'], gFrames['flagFlying'][self.currentAnimation:getCurrentFrame()], math.floor(self.x) + 8, math.floor(self.y) + 8, 0, 1, 1, 8, 10)

	-- love.graphics.draw(gTextures['toppers'], gFrames['toppersets'][self.topperset][self.id], (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end
