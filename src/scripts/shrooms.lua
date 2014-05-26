--[[
    Shrooms script
	@author Kevin Nilsson( TheOddByte )
	@version 1.0
--]]


local shrooms = {}
shrooms.__index = shrooms


local w, h = love.window.getDimensions()
local checkup = {
    {
	    score = 50;
		rate  = 2.5;
	};
	{
		score = 250;
		rate  = 1.5;
	};
	{
		score = 500;
		rate  = 1;
	};
	{
	    score = 1000;
		rate  = 0.75;
	};
	{
	    score = 2000;
		rate  = 0.5;
	};
}

shrooms.new = function()
    local shr = {
	    move_rate   = 0.025;
		move_timer  = 0;
		spawn_rate  = 5;
		spawn_timer = 0;
	}
	setmetatable( shr, shrooms )
	return shr
end


function shrooms:spawn()
	local shroom = {
		animate = false;
	    image   = love.graphics.newImage( "src/images/shroom.png" )
	}
	shroom.x = math.random( shroom.image:getWidth(), w - shroom.image:getWidth() )
	shroom.y = 0 - shroom.image:getHeight()
	table.insert( self, shroom )
end


function shrooms:update( dt )

	--# Check and see if the spawn rate should be faster
    for i = 1, #checkup do
	    if player.score >= checkup[i].score then
		    self.spawn_rate = checkup[i].rate
		end
	end
	
	--# Check if shroom already have nudged the pipe
	for i = 1, #self do
		if self[i].animate then
			self[i].x = (player.x + player.image:getWidth()/2) - self[i].image:getWidth()/2
		end
	end
	
	--# Handle spawning
    if self.spawn_timer < self.spawn_rate then
	    self.spawn_timer = self.spawn_timer + dt
	else
	    self.spawn_timer = 0;
	    self:spawn()
	end
	
	--# Handle moving
    if self.move_timer < self.move_rate then
	    self.move_timer = self.move_timer + dt
	else
		self.move_timer = 0
		for i = 1, #self do
		    self[i].y = math.ceil(self[i].y + dt*350)
			if self[i].y >= player.y then
			    if self[i].x >= player.x and self[i].x <= player.x + player.image:getWidth() then
				    if self[i].animate then
						player.score = player.score + 10
						table.remove( self, i )
						break
					end
				end
			end
			if self[i].y + self[i].image:getHeight() >= player.y then
				if self[i].x + self[i].image:getWidth() >= player.x and self[i].x <= player.x + player.image:getWidth() then
				    self[i].image = love.graphics.newImage( "src/images/shroom_cat.png" )
					if not self[i].animate then
						local audio = love.audio.newSource( "src/sound/pipe.mp3" )
						love.audio.play(audio)
					end
					self[i].animate = true
				end
			end
			if self[i].y + self[i].image:getHeight() >= h - block:getHeight() then
			    repeat
					for v = 1, #self do
						if v ~= i then
							table.remove( self, v )
							break
						end
					end
				until #self == 1
				love.audio.stop()
				local audio = love.audio.newSource( "src/sound/death.mp3" )
				love.audio.play(audio)
				game.over    = true
				break
			end
		end
	end
end    


function shrooms:draw()
    for i = 1, #self do
	    love.graphics.draw( self[i].image, self[i].x, self[i].y )
	end
end


return shrooms