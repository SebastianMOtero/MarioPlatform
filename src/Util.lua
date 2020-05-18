function GenerateQuads(atlas, tilewidth, tileheight)
	local sheetWidth = atlas:getWidth() / tilewidth
	local sheetHeight = atlas:getHeight() / tileheight

	local sheetCounter = 1
	local spritesheet = {}

	for y = 0, sheetHeight - 1 do
		for x = 0, sheetWidth - 1 do
			spritesheet[sheetCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
			sheetCounter = sheetCounter + 1
		end
	end

	return spritesheet
end

function GenerateTileSets(quads, setsX, setsY, sizeX, sizeY)
	local tilesets = {}
	local tableCounter = 0
	local sheetWidth = setsX * sizeX
	local sheetHeight = setsY * sizeY

	-- loop over 60 sets (setsY = 10 & setsX = 6)
	for tilesetY = 1, setsY do
		for tilesetX = 1, setsX do
			
			table.insert(tilesets, {})
			tableCounter = tableCounter + 1
			
			--every set has 20 tiles (sizeX = 5, sizeY = 4)
			for y = sizeY * (tilesetY - 1) + 1, sizeY * (tilesetY - 1) + 1 + sizeY do
				for x = sizeX * (tilesetX - 1) + 1, sizeX * (tilesetX - 1) + 1 + sizeX do
					table.insert(tilesets[tableCounter], quads[sheetWidth * (y - 1) + x])
				end
			end
		end
	end

	return tilesets
end

function GenerateFlyingFlag(quads)
	local flagFlying = {}
	local tableCounter = 0
	for flagY = 1, 4 do
		tableCounter = tableCounter + 1
		table.insert(flagFlying, {})
		for x = 7, 9 do
			table.insert(flagFlying[tableCounter], quads[(flagY - 1) * 9 + x])
		end
	end

	return flagFlying
end