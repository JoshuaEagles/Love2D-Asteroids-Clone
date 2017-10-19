player = require "Objects.Player"
require "Logic.CalculateMovementDirection"
require "Objects.Bullet"
require "Objects.AsteroidSmall"
require "Objects.AsteroidLarge"
require "Logic.AsteroidsSpawning"

bullets = {}
bulletNextTimer = 0

asteroidsSmall = {}
asteroidsLarge = {}

score = 0

function love.load()
	math.randomseed(os.time())
	
	if arg[#arg] ==  "-debug" then require("mobdebug").start() end --this is for debug purposes 
	canvas = love.graphics.newCanvas(256, 192)
	love.graphics.setDefaultFilter('nearest', 'nearest', 1)
	font = love.graphics.newFont("ABeeZee-Regular.otf", 8)
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear(0, 0, 0, 255)
		player.draw()
		
		for _, bullet in pairs(bullets) do
			bulletDraw(bullet)
		end --for
		
		for _, asteroidSmall in pairs(asteroidsSmall) do
			asteroidSmallDraw(asteroidSmall)
		end --for
		
		for _, asteroidLarge in pairs(asteroidsLarge) do
			asteroidLargeDraw(asteroidLarge)
		end
		
		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.setFont(font)
		love.graphics.print("Score: " .. score, 2, 2)
	love.graphics.setCanvas()
	
	love.graphics.setColor(256,256,256,256)
	love.graphics.draw(canvas, 0, 0, 0, 3)
end

function love.update(dt)
	asteroidsSpawningUpdate(dt)
	
	--order here is important, large asteroids can spawn small ones, if the order was reversed there is a crash if you interact with a small asteroid the same frame it spawns
	for _, asteroidLarge in pairs(asteroidsLarge) do
		asteroidLargeUpdate(dt, asteroidLarge)
	end -- for
	
	for _, asteroidSmall in pairs(asteroidsSmall) do
		asteroidSmallUpdate(dt, asteroidSmall)
	end --for
	
	player.update(dt)
	
	--collision with borders of the screen
	for _, bullet in pairs(bullets) do
		bulletUpdate(dt, bullet)
	end --for
end -- love.update

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end --if
end --love.keypressed