-- Tile.lua

local Tile = {}
Tile.__index = Tile

-- Constructor for the Tile class
function Tile.new(value, graphic)
    local self = setmetatable({}, Tile)
    self.value = value or 1 -- Default value is 1 if not provided
    self.selected = false    -- Default selected state is false
    self.visible = true      -- Default visible state is true
    self.graphic = graphic   -- File path to the graphic (string)
    return self
end

-- Getter for value
function Tile:getValue()
    return self.value
end

-- Setter for value
function Tile:setValue(newValue)
    if newValue >= 1 and newValue <= 9 then
        self.value = newValue
    else
        error("Value must be between 1 and 9.")
    end
end

-- Getter for selected state
function Tile:isSelected()
    return self.selected
end

-- Setter for selected state
function Tile:setSelected(state)
    self.selected = state
end

-- Getter for visible state
function Tile:isVisible()
    return self.visible
end

-- Setter for visible state
function Tile:setVisible(state)
    self.visible = state
end

-- Getter for graphic
function Tile:getGraphic()
    return self.graphic
end

-- Setter for graphic
function Tile:setGraphic(graphic)
    self.graphic = graphic
end

return Tile
