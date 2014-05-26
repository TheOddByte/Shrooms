--[[
    [API] Draw
	@author Kevin Nilsson( TheOddByte )
	@version 1.0
--]]


return{

	centerPrint = function( y, text )
		local w, h = love.window.getDimensions()
		if text ~= nil then
			love.graphics.printf( text, 0, y, w, "center")
		else
			love.graphics.printf( "nil", 0, y, w, "center")
		end
	end;

	
	image = function( filename, properties )
		local image = love.graphics.newImage( filename )
		local img_w, img_h = image:getDimensions()
		if properties.centered then
			love.graphics.draw( image, (w/2 - img_w/2), properties.y )
		else
			love.graphics.draw( image, properties.x, properties.y )
		end
		return img_w, img_h
	end;
	
	
    setFont = function( filename, font_size )
		local font = love.graphics.newFont( filename, font_size )
		love.graphics.setFont( font )
	end;
}

