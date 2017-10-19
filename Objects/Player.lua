player = {}
player.x = 64
player.y = 64
player.rotation = 0
player.rotationSpeed = 0
player.rotationDir = false
player.sx = 0
player.sy = 0
player.sdx = 0
player.sdy = 0
player.speed = 0
player.lives = 3

function player.load()
	player.x = 64
	player.y = 64
	player.rotation = 0
	player.rotationSpeed = 0
	player.sx = 0
	player.sy = 0
	player.speed = 0
	
	if player.lives <=  0 then
		player.lives = 3
		score = 0
		asteroidsSmall = {}
		asteroidsLarge = {}
	end --if
	
end -- player.load

function player.draw()
	love.graphics.setColor(255, 255, 255, 255)
	--these three calls just draw the player. no they dont work all in one method, idk why
	love.graphics.line(player.x + player.dx * 7, player.y + player.dy * 7, player.x + player.dx2 * 10, player.y + player.dy2 * 10)
	love.graphics.line(player.x + player.dx2 * 10, player.y + player.dy2 * 10, player.x + player.dx3 * 10, player.y + player.dy3 * 10)
	love.graphics.line(player.x + player.dx3 * 10, player.y + player.dy3 * 10, player.x + player.dx * 7, player.y + player.dy * 7)
end --player.draw

function player.update(dt)
	bulletNextTimer = bulletNextTimer - dt
	
	--d values are the multiplier used to draw lines at specific angles
	player.dx, player.dy = calculateMovementDirection(player.rotation)
	player.dx2, player.dy2 = calculateMovementDirection(player.rotation + 2.5)
	player.dx3, player.dy3 = calculateMovementDirection(player.rotation - 2.5)
	
	--p values are a table of points on each line, used to ensure that there is no shenanigans with collisions 
	-- 1st value is the front, at the tip of the triangle, p2 is the point that would be on the left if it was upright, p3 is the opposite side of p2
	-- 4th value is between p2 and p3, second and 5th and 6th values are between p and p2, 7th and 8th are p and p3
	player.px = {player.x + player.dx * 7, player.x + player.dx2 * 10, player.x + player.dx3 * 10, player.x + player.dx * -7, player.x + player.dx2 * 2.5, 	
		player.x + player.dx2 * 5, player.x + player.dx2 * 7.5, player.x + player.dx3 * 2.5, player.x + player.dx3 * 5, player.x + player.dx3 * 7.5} 
	player.py = {player.y + player.dy * 7, player.y + player.dy2 * 10, player.y + player.dy3 * 10, player.y + player.dy * -7, player.y + player.dy2 * 2.5, player.y 
		+ player.dy2 * 5, player.y + player.dy2 * 7.5, player.y + player.dy3 * 2.5, player.y + player.dy3 * 5, player.y + player.dy3 * 7.5}

	for _, asteroidSmall in pairs(asteroidsSmall) do
		for i = 1, 8 do
			if player.px[i] > asteroidSmall.px and player.px[i] < asteroidSmall.px2 and
				player.py[i] > asteroidSmall.py and player.py[i] < asteroidSmall.py2 then
				player.lives = player.lives - 1
				player.load()
				asteroidSmallRemove(asteroidSmall)
				return
			end -- if
		end --for
	end -- for
	
	for _, asteroidLarge in pairs(asteroidsLarge) do
		for i = 1, 8 do
			if player.px[i] > asteroidLarge.px and player.px[i] < asteroidLarge.px2 and
				player.py[i] > asteroidLarge.py and player.py[i] < asteroidLarge.py2 then
				player.lives = player.lives - 1
				player.load()
				asteroidLargeRemove(asteroidLarge)
				return
			end -- if
		end -- for
	end -- for

	player.x = player.x + player.sx * dt * player.sdx
	player.y = player.y + player.sy * dt * player.sdy	
	
	if love.keyboard.isDown('w') then
		if player.speed < 50 then
			player.speed = player.speed + 5
		end -- if
		player.sdx = player.dx
		player.sdy = player.dy
		player.x = player.x + player.speed * dt * player.dx
		player.y = player.y + player.speed * dt * player.dy
		player.sx = player.speed
		player.sy = player.speed
	elseif player.sx > 0 or player.sy > 0 then
		player.speed = 0
		if player.sx > 0 then
			player.sx = player.sx - 0.5
		end --if
		if player.sy > 0 then
			player.sy = player.sy - 0.5
		end --if
	end --if elseif
	
	if love.keyboard.isDown('a') then
		player.rotationSpeed = 3
		player.rotationDir = true
		if player.rotation - player.rotationSpeed * dt < 0 then
			player.rotation = player.rotation + 6.28319
		end -- if
	end -- if
	if love.keyboard.isDown('d') then
		player.rotationSpeed = 3
		player.rotationDir = false
		if player.rotation + player.rotationSpeed * dt > 6.28319 then
			player.rotation = player.rotation - 6.28319
		end --if
	end --if
	
	if player.rotationSpeed > 0 then
		if player.rotationDir == true then
			player.rotation = player.rotation - player.rotationSpeed * dt
		else
			player.rotation = player.rotation + player.rotationSpeed * dt
		end -- if
		player.rotationSpeed = player.rotationSpeed - 0.15
	end -- if
	
	if love.keyboard.isDown('space') then
		if #bullets < 3 and bulletNextTimer < 0 then
			bulletNextTimer = 0.3
			local bullet = {}
			bullet.x = player.x + 7 * player.dx
			bullet.y = player.y + 7 * player.dy
			bullet.dx = player.dx
			bullet.dy = player.dy
			table.insert(bullets, bullet)
		end
	end -- if elseif
	
	if player.x < 0 then
		player.x = 256
	elseif player.x > 256 then
		player.x = 0
	end -- if
	if player.y < 0 then
		player.y = 192
	elseif player.y > 192 then
		player.y = 0
	end
end --player.update

return player