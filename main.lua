--[[
    [Game] Shrooms!
	@author Kevin Nilsson( TheOddByte )
	@version 1.0
--]]

local w, h = love.window.getDimensions()


function love.load()

	game = {
	    running   = false;
		over      = false;
		over_anim = false;
	}

	love.window.setTitle( "Shrooms!" )
    local icon = love.image.newImageData( "src/images/shroom_cat.png" )
	love.window.setIcon( icon )
	
	background = love.image.newImageData( "src/images/background.jpg" )
	
	--# Get some scripts
    draw = require( "src/apis/draw" )
	p    = require( "src/scripts/player" )
	shr  = require( "src/scripts/shrooms" )
	
	love.audio.setVolume( 0.4 )
	
	shrooms = shr.new()
	
	--# Initialize images and font
	draw.setFont( "src/fonts/Mario-Kart-DS.ttf", 48 )
	background = love.graphics.newImage( "src/images/background.jpg" )
	block      = love.graphics.newImage( "src/images/block.png" )
	 
	--# Create the player
	player = p.new( "TheOddByte" )
	player.score = 0;
	
end

function love.update( dt )
    if game.running and not game.over then
		if love.keyboard.isDown( "d" ) or love.keyboard.isDown( "right" ) then
			player.x = player.x + math.ceil(dt*400)
			if player.x + player.image:getWidth() > w then
			    player.x = w - player.image:getWidth()
			end
			
		elseif love.keyboard.isDown( "a" ) or love.keyboard.isDown( "left" ) then
			player.x = player.x - math.ceil(dt*400)
			if player.x < 1 then
			    player.x = 0
			end
		end
		shrooms:update( dt )
	end
end


function love.keypressed( key, unicode )
    if not game.running then
	    game.running = true
		local song = love.audio.newSource( "src/sound/soundtrack.mp3", "stream" )
		song:setLooping( true )
		love.audio.play(song)
	else
	    if game.over then
		    shrooms = shr.new()
			player.x     = w/2- player.image:getWidth()/2 
			player.score = 0
			game.over    = false;
			game.running = false;
		end
	end
end


function love.draw()
    love.graphics.setColor( 255,255,255,255 )
	love.graphics.setBackgroundColor( 193,235,236 )
	love.graphics.draw( background, 0, 0 )
	
	--# Draw the shrooms & the player( pipe )
	shrooms:draw()
	player:draw()
	
	--# Draw blocks
	local x = 0
	while x < w do
	    love.graphics.draw( block, x, h - block:getHeight() )
		x = x + (block:getWidth()-1)
	end
	 
	--# Draw score
	love.graphics.setColor( 75,75,75,220 )
	if game.running then
	    if not game.over then
			draw.centerPrint( 48*3, tostring( player.score ) )
		else
			draw.centerPrint( h/2-48, "Game Over\n\nScore\n" .. player.score )
		end
	else
		draw.centerPrint( h/2-24, "Press Any Key to Start" )
	end
    
end
