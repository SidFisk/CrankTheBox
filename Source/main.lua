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
local titleEnterAnimator = gfx.animator.new(1000, -100, 120, pd.easingFunctions.inOutElastic)

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
local gameFlavor = nil -- Tracks the flavor of the game
local classic = 1 -- Single row of tiles
local double = 2 -- Double row of tiles
local triple = 3 -- Triple row of tiles
local gamePhase = nil -- Tracks phase of game
local showTitlePhase = 1 -- Show the title card
local parkTitlePhase = 2 -- Show the title card
local instructionsPhase = 3 -- Show the instructions card
local instructionsParkPhase = 4
local flavorPhase = 5 -- Show the card to allow to select game flavor
local flavorParkPhase = 6
local tileFlyPhase = 7-- Bring in the tiles!
local rollPhase = 8 -- Phase to roll the dice
local tilePhase = 9 -- Phase to select and crank away tiles
local endPhase = 19 -- Endgame phase to show final score and high scores
local flavorXcord = 100 -- X coordinate for the flavor selector
local flavorYcord = 100 -- Y coordinate for the flavor selector
local badgeXcord = 132 -- X coordinate for the flavor badge
local badgeYcord = 200 -- Y coordinate for the flavor badge

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
		instructionsEnterAnimator = gfx.animator.new(1000, -100, 82, pd.easingFunctions.inOutElastic)
		gamePhase = instructionsPhase
	end
end


local function showInstructionCard()
	instructionCard:add()
	local enterY = instructionsEnterAnimator:currentValue()
	instructionCard:moveTo(200, enterY)
	if pd.buttonJustPressed(pd.kButtonA) then
		instructionsParkAnimator = gfx.animator.new(750, 82, -100, pd.easingFunctions.inOutElastic)
		gamePhase = instructionsParkPhase
	end
end

local function parkInstructionCard()
	local enterY = instructionsParkAnimator:currentValue()
	instructionCard:moveTo(200, enterY)
	if instructionsParkAnimator:ended() then
		instructionCard:remove()
		flavorEnterAnimator = gfx.animator.new(1000, -100, 82, pd.easingFunctions.inOutElastic)
		gamePhase = flavorPhase
	end
end

local function showFlavorCard()
	flavorCard:add()
	local enterY = flavorEnterAnimator:currentValue()
	flavorCard:moveTo(200, enterY)

	if flavorEnterAnimator:ended() then
		
		selectorSprite:add()

		if gameFlavor == classic then
			flavorXcord = 249
			flavorYcord = 61
		elseif gameFlavor == double then
			flavorXcord = 249
			flavorYcord = 83
		elseif gameFlavor == triple then
			flavorXcord = 249
			flavorYcord = 105
		end

		selectorSprite:moveTo(flavorXcord, flavorYcord)

	end

	if playdate.buttonJustPressed(playdate.kButtonDown) then
		gameFlavor += 1
		if gameFlavor > 3 then gameFlavor = 3 end
	end

	if playdate.buttonJustPressed(playdate.kButtonUp) then
		gameFlavor -= 1
		if gameFlavor < 1 then gameFlavor = 1 end 
	end

	if pd.buttonJustPressed(pd.kButtonA) then
		flavorParkAnimator = gfx.animator.new(750, 82, -100, pd.easingFunctions.inOutElastic)
		gamePhase = flavorParkPhase
		selectorSprite:remove()
	end
end

local function parkFlavorCard()
	local enterY = flavorParkAnimator:currentValue()
	flavorCard:moveTo(200, enterY)	
	if flavorParkAnimator:ended() then
		flavorCard:remove()
		gamePhase = tileFlyPhase
		if gameFlavor == classic then
			classicSprite:add()
		elseif gameFlavor == double then
			doubleSprite:add()
		elseif gameFlavor == triple then
			tripleSprite:add()
		end
		scoreSprite:add()
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

local selectorImage = gfx.image.new("images/selector")
	selectorSprite = gfx.sprite.new(selectorImage)

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
gameFlavor = classic

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
elseif gamePhase == instructionsParkPhase then
	parkInstructionCard()
	gfx.sprite.update()
elseif gamePhase == flavorPhase then
	showFlavorCard()
	gfx.sprite.update()
elseif gamePhase == flavorParkPhase then
	parkFlavorCard()
	gfx.sprite.update()
elseif gamePhase == tileFlyPhase then
	
	gfx.sprite.update()
end

end



