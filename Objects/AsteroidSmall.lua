function asteroidSmallDraw(asteroid)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle('line', asteroid.x, asteroid.y, 5)
end

function asteroidSmallUpdate(dt, asteroid)
	asteroid.x = asteroid.x + asteroid.dx * 80 * dt
	asteroid.y = asteroid.y + asteroid.dy * 80 * dt
	
	-- p values are positions of specific points, these two are the two 45 degree edges, hitboxes are just squares, idk how to do circle ones efficiently
	asteroid.px, asteroid.py = asteroid.x - 4, asteroid.y - 4
	asteroid.px2, asteroid.py2 = asteroid.x + 4, asteroid.y + 4
	
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
end -- asteroidSmallUpdate

function asteroidSmallRemove(asteroid)
	for i, tableAsteroid in pairs(asteroidsSmall) do
		if tableAsteroid == asteroid then
			table.remove(asteroidsSmall, i)
		end --if
	end -- for
end--asteroidSmallRemove