-- Notes -- CRANK = "Hotel Royal" THE BOX = "High Tower"

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/animator"

--Shortcuts
local gfx <const> = playdate.graphics
local snd = playdate.sound
local pd = playdate

--Animators
local titleEnterAnimator = gfx.animator.new(2000, -200, 120, pd.easingFunctions.inOutElastic)
local titleLeaveAnimator = gfx.animator.new(2000, 240, 400, pd.easingFunctions.inOutElastic)

--Sounds


--Sprites
local classicSprite = nil    -- Classic game badge
local doubleSprite = nil     -- Double game badge
local tripleSprite = nil     -- Triple game badge
local titleCard = nil        -- Title Graphic for when the game first starts
local instructionCard = nil  -- Instructions for the game -- seen after the title

--Variables
local gamePhase = nil -- Tracks phase of game
local showTitlePhase = 1 -- Show the title card
local hideTitlePhase = 2 -- Show the title card
local instructionsPhase = 3 -- Show the instructions card
local flavorPhase = 4 -- Show the card to allow to select game flavor
local rollPhase = 5 -- Phase to roll the dice
local tilePhase = 6 -- Phase to select and crank away tiles
local endPhase = 7 -- Endgame phase to show final score and high scores
local badgeXcord = 132 -- X cordinate for the flavor badge
local badgeYcord = 217 -- Y cordinate for the flavor badge

local function showTitleCard()
	titleCard:add()
	local enterY = titleEnterAnimator:currentValue()
	titleCard:moveTo(200, enterY)
	if playdate.buttonJustPressed(playdate.kButtonA) then
		gamePhase = hideTitlePhase
	end
end

local function hideTitleCard()
	local leaveX = titleLeaveAnimator:currentValue()
	titleCard:moveTo(leaveX, 120)
	if titleLeaveAnimator:ended() then
		titleCard:remove()
		gamePhase = instructionsPhase
	end
end


local function showInstructioncard()
	instructionCard:add()
	if playdate.buttonJustPressed(playdate.kButtonA) then
		instructionCard:remove()
		gamePhase = flavorPhase
	end
end

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

local instructionImage = gfx.image.new("images/instructionCard")
	instructionCard = gfx.sprite.new(instructionImage)
	instructionCard:moveTo(200,120)	

local titleImage = gfx.image.new("images/titleCard")
	titleCard = gfx.sprite.new(titleImage)

local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(
		function (x, y, width, height)
			gfx.setClipRect(x,y,width,height)
			backgroundImage:draw(0,0)
			gfx.clearClipRect()
		end
	)
gamePhase = showTitlePhase

end

initialize()

function playdate.update()

if gamePhase == showTitlePhase then
	showTitleCard()
	gfx.sprite.update()
elseif gamePhase == hideTitlePhase then
	hideTitleCard()
	gfx.sprite.update()
elseif gamePhase == instructionsPhase then
	showInstructioncard()
	gfx.sprite.update()
elseif gamePhase == flavorPhase then
	tripleSprite:add()
	gfx.sprite.update()
end

end



