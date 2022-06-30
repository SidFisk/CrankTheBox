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

--Initial Animator
local titleEnterAnimator = gfx.animator.new(2000, -100, 120, pd.easingFunctions.inOutElastic)

--Sounds


--Sprites
local classicSprite = nil    -- Classic game badge
local doubleSprite = nil     -- Double game badge
local tripleSprite = nil     -- Triple game badge
local titleCard = nil        -- Title Graphic for when the game first starts
local instructionCard = nil  -- Instructions for the game -- seen after the title
local flavorCard = nil -- Card to choose your game version
local scoreSprite = nil -- Score card for the titleCard

--Variables
local playTimer = nil 
local gamePhase = nil -- Tracks phase of game
local showTitlePhase = 1 -- Show the title card
local parkTitlePhase = 2 -- Show the title card
local instructionsPhase = 3 -- Show the instructions card
local flavorPhase = 4 -- Show the card to allow to select game flavor
local tileFlyPhase = 5 -- Bring in the tiles!
local rollPhase = 6 -- Phase to roll the dice
local tilePhase = 7 -- Phase to select and crank away tiles
local endPhase = 8 -- Endgame phase to show final score and high scores
local badgeXcord = 132 -- X cordinate for the flavor badge
local badgeYcord = 200 -- Y cordinate for the flavor badge

local function showTitleCard()
	titleCard:add()
	local enterY = titleEnterAnimator:currentValue()
	titleCard:moveTo(200, enterY)
	if titleEnterAnimator:ended() then
		titleParkAnimator = gfx.animator.new(2000, 120, 200, pd.easingFunctions.inOutElastic,500)
		gamePhase = parkTitlePhase
	end
end

local function parkTitleCard()
	local parkY = titleParkAnimator:currentValue()
	titleCard:moveTo(200, parkY)
	if titleParkAnimator:ended() then
		instructionsEnterAnimator = gfx.animator.new(2000, -100, 82, pd.easingFunctions.inOutElastic)
		gamePhase = instructionsPhase
	end
end


local function showInstructionCard()
	instructionCard:add()
	local enterY = instructionsEnterAnimator:currentValue()
	instructionCard:moveTo(200, enterY)
	if pd.buttonJustPressed(pd.kButtonA) then
		instructionCard:remove()
		flavorEnterAnimator = gfx.animator.new(2000, -100, 82, pd.easingFunctions.inOutElastic)
		gamePhase = flavorPhase
	end
end

local function showFlavorCard()
	flavorCard:add()
	local enterY = flavorEnterAnimator:currentValue()
	flavorCard:moveTo(200, enterY)
	if pd.buttonJustPressed(pd.kButtonA) then
		flavorCard:remove()
		gamePhase = tileFlyPhase
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

local flavorImage = gfx.image.new("images/flavorCard")
	flavorCard = gfx.sprite.new(flavorImage)

local instructionImage = gfx.image.new("images/instructionCard")
	instructionCard = gfx.sprite.new(instructionImage)
		
local titleImage = gfx.image.new("images/titleCard")
	titleCard = gfx.sprite.new(titleImage)

local classicImage = gfx.image.new("images/classic")
	classicSprite = gfx.sprite.new(classicImage)
	classicSprite:moveTo(badgeXcord, badgeYcord)
	
local scoreImage = gfx.image.new("images/score")
	scoreSprite = gfx.sprite.new(scoreImage)
	scoreSprite:moveTo(290, 200)	

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

function pd.update()


if gamePhase == showTitlePhase then
	showTitleCard()
	gfx.sprite.update()
elseif gamePhase == parkTitlePhase then
	parkTitleCard()
	gfx.sprite.update()
elseif gamePhase == instructionsPhase then
	showInstructionCard()
	gfx.sprite.update()
elseif gamePhase == flavorPhase then
	showFlavorCard()
	gfx.sprite.update()
elseif gamePhase == tileFlyPhase then
	classicSprite:add()
	scoreSprite:add()
	gfx.sprite.update()
end

end



