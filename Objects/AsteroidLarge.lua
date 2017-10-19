function asteroidLargeDraw(asteroid)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle('line', asteroid.x, asteroid.y, 10)
end

function asteroidLargeUpdate(dt, asteroid)
	asteroid.x = asteroid.x + asteroid.dx * 80 * dt
	asteroid.y = asteroid.y + asteroid.dy * 80 * dt
	
	-- p values are positions of specific points, these two are the two 45 degree edges, hitboxes are just squares, idk how to do circle ones efficiently
	asteroid.px, asteroid.py = asteroid.x - 9, asteroid.y - 9
	asteroid.px2, asteroid.py2 = asteroid.x + 9, asteroid.y + 9
	
	if asteroid.x < 0 then
		asteroid.x = 256
	elseif asteroid.x > 256 then
		asteroid.x = 0
	end -- if elseif
	
	if asteroid.y < 0 then
		asteroid.y = 192
	elseif asteroid.y > 192 then
		asteroid.y = 0 
	end -- if elseif
end --asteroidLargeUpdate

function asteroidLargeRemove(asteroid)
	local asteroidRotation = asteroid.rotation
	local asteroidX = asteroid.x
	local asteroidY = asteroid.y
	for i, tableAsteroid in pairs(asteroidsLarge) do
		if tableAsteroid == asteroid then
			table.remove(asteroidsLarge, i)
		end --if
	end -- for
	asteroidsSpawningUpdate(0, true, asteroidRotation + 1.5, asteroidX, asteroidY)
	asteroidsSpawningUpdate(0, true, asteroidRotation - 1.5, asteroidX, asteroidY)
end--asteroidLargeRemove