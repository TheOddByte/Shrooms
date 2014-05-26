--[[
	Player Script
	@author Kevin Nilsson( TheOddByte )
	@version 1.0
--]]


local player = {}
player.__index = player


local w, h = love.window.getDimensions()





player.new = function( name )
     local p = {
	    name  = name;
		x     = nil;
		y     = nil;
		image = love.graphics.newImage( "src/images/pipe.png" );
		show  = true;
	}
	p.x = w/2-p.image:getWidth()/2 
	p.y = h-p.image:getHeight()
	setmetatable( p, player )
	return p
end


function player:draw()
	if self.show then
		love.graphics.setColor( 255,255,255,255 )
		love.graphics.draw( self.image, self.x, self.y  )
    end
end



return player