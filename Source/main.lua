import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"

--Shortcuts
local gfx <const> = playdate.graphics
local snd = playdate.sound

--Sounds


--Sprites
local classicSprite = nil  -- Classic game badge
local doubleSprite = nil   -- Double game badge
local tripleSprite = nil   -- Triple game badge

--Variables
local badgeXcord = 132
local badgeYcord = 217



local function initialize()
--initialize gamescreen.  Adds all sprites, backgrounds, to default locations

local classicImage = gfx.image.new("images/classic")
	classicSprite = gfx.sprite.new(classicImage)
	classicSprite:moveTo(badgeXcord, badgeYcord)	

local doubleImage = gfx.image.new("images/double")
	doubleSprite = gfx.sprite.new(doubleImage)
	doubleSprite:moveTo(badgeXcord, badgeYcord)	

	local tripleImage = gfx.image.new("images/triple")
	tripleSprite = gfx.sprite.new(tripleImage)
	tripleSprite:moveTo(badgeXcord, badgeYcord)	

local backgroundImage = gfx.image.new("images/background_backup")
	gfx.sprite.setBackgroundDrawingCallback(
		function (x, y, width, height)
			gfx.setClipRect(x,y,width,height)
			backgroundImage:draw(0,0)
			gfx.clearClipRect()
		end
	)
end

initialize()

function playdate.update()
	--classicSprite:add()
	--doubleSprite:add()
	tripleSprite:add()
	gfx.sprite.update()
end



