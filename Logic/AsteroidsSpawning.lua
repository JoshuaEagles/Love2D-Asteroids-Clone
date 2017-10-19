spawnerTimer = 0

function asteroidsSpawningUpdate(dt, isSmall, specificRotation, specificPosX, specificPosY)
	spawnerTimer = spawnerTimer - dt
	if spawnerTimer < 0 or isSmall ~= nil then
		if isSmall == nil then
			spawnerTimer = 3
		end --if
		--this is what decides if to spawn a small or large asteroid, true == small asteroid
		if isSmall or toBool(math.random()) then
			local asteroidSmall = {}
			asteroidSmall.x = specificPosX or 0
			asteroidSmall.y = specificPosY or 0
			asteroidSmall.rotation = specificRotation or math.random() * 6.28319
			asteroidSmall.dx, asteroidSmall.dy = calculateMovementDirection(asteroidSmall.rotation)
			table.insert(asteroidsSmall, asteroidSmall)
		else
			local asteroidLarge = {}
			asteroidLarge.x, asteroidLarge.y = 0, 0
			asteroidLarge.rotation = math.random() * 6.28319
			asteroidLarge.dx, asteroidLarge.dy = calculateMovementDirection(asteroidLarge.rotation)
			table.insert(asteroidsLarge, asteroidLarge)
		end --if else
	end -- if
end --asteroidSpawningUpdate

function toBool(int)
	if int > 0.49 then
		return true
	else
		return false
	end --if else
end --toBool