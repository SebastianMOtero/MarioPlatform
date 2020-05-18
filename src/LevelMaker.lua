LevelMaker = Class{}

function LevelMaker.generate(width, height)
	local tiles = {}
	local entities = {}
	local objects = {}
	local flag
	local tileID = TILE_ID_GROUND

	local topper = true
	local tileset = math.random(60)
	local topperset = math.random(108)

	groundLevel = 7

	for x = 1, height do
		table.insert(tiles, {})
	end

	for x = 1, width do
		local tileID = TILE_ID_EMPTY

		--empty space, sky
		for y = 1, groundLevel-1 do
			table.insert(tiles[y], Tile(x, y, tileID, false, tileset, topperset))
		end

		-- add no ground if the previous is ground and then no ground
		if x > 3 and tiles[10][x-2]:collidable() and not tiles[10][x-1]:collidable() and x < width - 3 then
			for y = groundLevel, height do
				table.insert(tiles[y], Tile(x, y, tileID, false, tileset, topperset))
			end
		
		-- no ground
		elseif math.random(7) == 1 and x > 3 and x < width - 3 then
			for y = groundLevel, height do
				table.insert(tiles[y], Tile(x, y, tileID, false, tileset, topperset))
			end

		-- generate ground
		else
			tileID = TILE_ID_GROUND

			local blockHeight = groundLevel - 3

			--fill up with ground
			for y = groundLevel, height do
				table.insert(tiles[y], Tile(x, y, tileID, y == groundLevel and topper or false, tileset, topperset))
			end
			
			if x == width - 2 then
			end
			--pillar
			if math.random(8) == 1 and x > 2 and groundLevel > 5 and x < width - 2 then
				if blockHeight - 2 > 1 then
					blockHeight = blockHeight - 2
				end

				--bush on pillar
				if math.random(8) == 1 then
					table.insert(objects, GameObject {
						texture = 'bushes',
						x = (x - 1) * TILE_SIZE,
						y = (groundLevel - 4) * TILE_SIZE,
						width = 16,
						height = 16,
						frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
						collidable = false
					})
				end

				tiles[groundLevel-2][x] = Tile(x, groundLevel-2, tileID, topper, tileset, topperset)
				tiles[groundLevel-1][x] = Tile(x, groundLevel-1, tileID, false, tileset, topperset)
				tiles[groundLevel][x].topper = false
			
			-- --bush on ground
			elseif math.random(8) == 1 then 
				table.insert(objects, GameObject {
					texture = 'bushes',
					x = (x - 1) * TILE_SIZE,
					y = (groundLevel - 2) * TILE_SIZE,
					width = 16,
					height = 16,
					frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
					collidable = false
				})
			end

			--spawn a block
			if math.random(10) == 1 and x > 2 and x < width - 2 then
				table.insert(objects, GameObject {
					texture = 'jump-blocks',
					x = (x - 1) * TILE_SIZE,
					y = (blockHeight - 1) * TILE_SIZE,
					width = 16,
					height = 16,
					frame = math.random(#JUMP_BLOCKS),
					collidable = true,
					hit = false,
					solid = true,

					onCollide = function(obj)

						if not obj.hit then
							if math.random(5) == 1 then
								local gem = GameObject {
									texture = 'gems',
									x = (x - 1) * TILE_SIZE,
									y = (blockHeight - 1) * TILE_SIZE - 4,
									width = 16,
									height = 16,
									frame = math.random(#GEMS),
									collidable = true,
									consumable = true,
									solid = false,

									onConsume = function(player, object)
										gSounds['pickup']:play()
										player.score = player.score + 100
									end
								}

								Timer.tween(0.1, {
									[gem] = {y = (blockHeight - 2) * TILE_SIZE}
								})
								gSounds['powerup-reveal']:play()

								table.insert(objects, gem)
							end

							obj.hit = true
						end

						gSounds['empty-block']:play()
					end
				})
			end

			if x == width - 2 then
				flag = Flag{
					texture = 'flag',
					x = (x - 1) * TILE_SIZE,
					y = (groundLevel - 4) * TILE_SIZE - 0,
					flag = math.random(4),
					flagpole = math.random(6),
					width = 16,
					height = 48,
				}
			end

			if math.random(10) == 1 and groundLevel < 9 then
				groundLevel = groundLevel + 1
			elseif math.random(10) == 9 and groundLevel > 4 then
				groundLevel = groundLevel - 1
			end
			
		end
	end

	local map = TileMap(width, height)
	map.tiles = tiles
	map.flag = flag
	return GameLevel(entities, objects, map)
end
