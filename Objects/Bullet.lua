function bulletDraw(bullet)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.line(bullet.x + -2 * bullet.dx, bullet.y + -2 * bullet.dy, bullet.x + 2 * bullet.dx, bullet.y + 2 * bullet.dy)
end

function bulletUpdate(dt, bullet)
	if bullet.x > 256 or bullet.y > 192 or bullet.x < 0 or bullet.y < 0 then
		bulletRemove(bullet)
		return
	end -- if
	
	for _, asteroidSmall in pairs(asteroidsSmall) do
		if asteroidSmall.px == nil or asteroidSmall.px2 == nil or asteroidSmall.py == nil or asteroidSmall.py2 == nil then
			return
		end --if
		
		if bullet.x > asteroidSmall.px and bullet.x < asteroidSmall.px2 and
						bullet.y > asteroidSmall.py and bullet.y < asteroidSmall.py2 then
			bulletRemove(bullet)
			score = score + 8
			asteroidSmallRemove(asteroidSmall)
			return
		end--if
	end --for
	
	for _, asteroidLarge in pairs(asteroidsLarge) do
		if bullet.x > asteroidLarge.px and bullet.x < asteroidLarge.px2 and
						bullet.y > asteroidLarge.py and bullet.y < asteroidLarge.py2 then
			bulletRemove(bullet)
			score = score + 4
			asteroidLargeRemove(asteroidLarge)
			return
		end --if
	end --for
	
	bullet.x = bullet.x + 250 * dt * bullet.dx
	bullet.y = bullet.y + 250 * dt * bullet.dy
end

function bulletRemove(bullet)
	for i, tableBullet in pairs(bullets) do
		if tableBullet == bullet then
			table.remove(bullets, i)
		end --if
	end -- for
end --removeBullet