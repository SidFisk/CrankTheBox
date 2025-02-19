-- main.lua

-- Require the Tile class from Tile.lua
local Tile = require("Tile")

-- Create a new Tile instance
local tile1 = Tile.new(5, "path/to/graphic1.png")
print("Tile value: " .. tile1:getValue())  -- Output the value of tile1
print("Tile selected: " .. tostring(tile1:isSelected()))  -- Output the selected state
print("Tile visible: " .. tostring(tile1:isVisible()))  -- Output the visible state
print("Tile graphic: " .. tile1:getGraphic())  -- Output the graphic path

-- Set new values
tile1:setValue(8)
tile1:setSelected(true)
tile1:setVisible(false)
tile1:setGraphic("path/to/graphic2.png")

-- Output the updated values
print("Updated Tile value: " .. tile1:getValue())
print("Tile selected after change: " .. tostring(tile1:isSelected()))
print("Tile visible after change: " .. tostring(tile1:isVisible()))
print("Updated Tile graphic: " .. tile1:getGraphic())
