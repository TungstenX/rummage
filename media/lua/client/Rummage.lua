require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISInventoryTransferAction"
require "ISUI/ISButton"

Rummage = Rummage or {}
Rummage.DEBUG = true
Rummage.FOUND = Rummage.FOUND or {
  getText("UI_RUMMAGE_FOUND_1"),
  getText("UI_RUMMAGE_FOUND_2"),
  getText("UI_RUMMAGE_FOUND_3"),
  getText("UI_RUMMAGE_FOUND_4"),
  getText("UI_RUMMAGE_FOUND_5")
}
Rummage.UI = Rummage.UI or {
  getText("UI_unpack_items_button"),
  getText("UI_undress_items_button")
}
Rummage.UI_TOOLTIP = Rummage.UI_TOOLTIP or {
  getText("UI_unpack_items_button_tooltip"),
  getText("UI_undress_items_button_tooltip")
}

-- Extract InventoryItem from Lua table containers
--
-- @param item An inventoryItem or something else
-- @return An inventoryItem
function Rummage.getSingleItem(item)
  if (item["items"] ~= nil) then
    return Rummage.getSingleItem(item["items"])
  elseif (type(item) == "table") then
    return Rummage.getSingleItem(item[1])
  else
    return item
  end
end

-- Transfer items from (source) container to (destination) floor
-- Will do nothing if the container is nil, empty or the floor (source == destination)
--
-- @param playerIndex The player's index
-- @param container An inventory container
function Rummage.transfer(playerIndex, container)
  if Rummage.DEBUG then print("Rummage.transfer") end
  if container == nil or container:isEmpty() or container == ISInventoryPage.GetFloorContainer(playerIndex) then
    if Rummage.DEBUG then print("Rummage.transfer no container, empty container or is the floor") end
    return
  end
  
  local items = container:getItems()
  local player = getSpecificPlayer(playerIndex)
  local destination = ISInventoryPage.GetFloorContainer(playerIndex) --player:getCurrentSquare():getFloor()
  local size = items:size()
  for i = 0, size - 1 do
    local inventoryItem = items:get(i)
    local item = Rummage.getSingleItem(inventoryItem)
    if item:getCategory() == Rummage.AllCat[Rummage.Options.lookFor1] then
      local say = Rummage.FOUND[ZombRand(#Rummage.FOUND) + 1] .. item:getDisplayName() .. " (" .. (item:getDisplayCategory() or item:getCategory()) .. ")"
      player:Say(say, 0.70, 0.24, 0.02, UIFont.Dialogue, 0, "default")
    end
    
      -- create "timed action" to transfer items (game api)      
    ISTimedActionQueue.add(ISInventoryTransferAction:new(player, item, item:getContainer(), destination))
  end
end

-- =====================
-- START DEBUG functions
-- =====================
local function leadingSpace(spaces)
  local ret = ""
  for _ = 0, spaces, 1 do
    ret = ret .. "  "
  end
  return ret
end

local function tableToString(t, spaces)
  if spaces > 1 then
    return ""
  end
  local tabSpace = leadingSpace(spaces)
  local ret = ""
  for k, v in pairs(t) do
    ret = ret .. tabSpace .. "(" .. k .. "): "
    if instanceof(v, 'table') then
      local newSpaces = spaces + 1
      local newTabSpace = leadingSpace(newSpaces)
      ret = ret .. tableToString(v, newSpaces)
    else
      ret = ret .. tostring(v)
    end
    ret = ret .. "\n"
  end
  return ret
end
-- ===================
-- END DEBUG functions
-- ===================

-- Get the index for the button title or tooltip
--
-- @param inventoryType The inventory type
-- @return either 1 or 2, 1 for creates and 2 for corpses
function Rummage.whichText(inventoryType)
  if inventoryType == 'inventorymale' or inventoryType == 'inventoryfemale' then
    return 2
  end
  return 1
end

-- Should the button shown or hidden
-- Don't show button if inventory is empty, or if the inventory is the floor or if the "Delete All" button is shown (trash can)
--
-- @param self, the ISInventoryPage's self
-- @return true or false. True, then show button else false, hide the button
function Rummage.showButton(self)
  local inv = self.inventory
  --if Rummage.DEBUG then print ("showButton: Is empty ", tostring(inv:isEmpty())) end
  -- Broken up to debug for errors
  local show = (inv and not inv:isEmpty())
  --if Rummage.DEBUG then print ("showButton: 1 ", tostring(show)) end
  if not show then return show end
  
  show = show and inv ~= ISInventoryPage.GetFloorContainer(self.player) 
  --if Rummage.DEBUG then print ("showButton: 2 ", tostring(show)) end
  if not show then return show end
  
  --Stove 
  if self.toggleStove then
    show = show and not self.toggleStove:getIsVisible()
    --if Rummage.DEBUG then print ("showButton: 3 ", tostring(show)) end
    if not show then return show end
  end
  
  -- trash can
  if isClient() then
    show = show and not getServerOptions():getBoolean("TrashDeleteAll")    
    --if Rummage.DEBUG then print ("showButton: 4 ", tostring(show)) end
    if not show then return show end
  end
  
	local obj = inv:getParent()
	if instanceof(obj, "IsoObject") then
    local sprite = obj:getSprite()
    if sprite and sprite:getProperties() then
      show = show and not sprite:getProperties():Is("IsTrashCan")
    end
  end
  
  --if Rummage.DEBUG then print ("showButton: 5 ", tostring(show)) end
  return show
end

-- Create "Unpack" (or "Undress") button on the loot container inventory UI
-- 
-- @param self, the ISInventoryPage's self
function Rummage.createUnpackItemsButton(self)
  if self.RummageUnpackItems == nil and not self.onCharacter then
    if Rummage.DEBUG then print ("createUnpackItemsButton inventoryPane: ", tostring(self.inventory)) end
    
    local textIndex = Rummage.whichText(self.inventory:getType())
    local title = Rummage.UI[textIndex]
    local tooltip = Rummage.UI_TOOLTIP[textIndex]
    
    local titleBarHeight = self:titleBarHeight()
    local lootButtonHeight = titleBarHeight
    --Pick the longest/widest text
    local textWidth1 = getTextManager():MeasureStringX(UIFont.Small, Rummage.UI[1])
    local textWidth2 = getTextManager():MeasureStringX(UIFont.Small, Rummage.UI[2])
    local textWidth = (textWidth1 >= textWidth2 and textWidth1 or textWidth2)
    
    local x = 3 + titleBarHeight * 2 + 1
    self.RummageUnpackItems = ISButton:new(x, 0, textWidth, lootButtonHeight, title, self, ISInventoryPage.RummageUnpackItemsClick)
    self.RummageUnpackItemsTooltip = false
    self.RummageUnpackItems:initialise()
    self.RummageUnpackItems.tooltip = tooltip
    self.RummageUnpackItems.borderColor.a = 0.0
    self.RummageUnpackItems.backgroundColor.a = 0.0
    self.RummageUnpackItems.backgroundColorMouseOver.a = 0.7
    self:addChild(self.RummageUnpackItems)
    self.RummageUnpackItems:setVisible(Rummage.showButton(self))
    self.KAtransferAllCompulsively = self.RummageUnpackItems -- old button name
  end
end

-- reference to original function
local ISInventoryPageCreateChildren = ISInventoryPage.createChildren

-- Override ISInventoryPage:createChildren to inject Rummage code
function ISInventoryPage:createChildren()
  ISInventoryPageCreateChildren(self) -- call original function
  pcall(Rummage.createUnpackItemsButton, self) -- pcall to prevent UI from crashing if this mod causes problems
end

-- "Unpack" (or "Undress") button click handler
function ISInventoryPage:RummageUnpackItemsClick()
  Rummage.transfer(self.player, self.inventory)
end

-- Find SmartStack mod button
-- 
-- @param self, the ISInventoryPage's self
function Rummage.findSmartStackToAllButton(self)
  if (self.children) then
    for _, selectedItem in pairs(self.children) do
      -- since it's not storing its references on the ISInventoryPage
      -- it can only be found by its title (somewhat unreliable)
      if (selectedItem.title == getText("UI_StackToAll")) then
        return selectedItem
      end
    end
  end
  return nil
end

-- Get "Unpack" (or "Undress") button offset to prevent overlapping with other UI elements
-- 
-- @param self, the ISInventoryPage's self
-- @return The x offset
function Rummage.getUnpackButtonOffset(self)
  local result = 0
  -- "Loot All" button
  if (self.lootAll:getIsVisible()) then
    result = self.lootAll:getRight() + 3
  end
  -- AutoLoot mod button
  if (self.stackItemsButtonIcon ~= nil and self.stackItemsButtonIcon:getIsVisible()) then
    result = self.stackItemsButtonIcon:getRight() + 3
  end
  -- Smart Stack mod button
  local smartStackButton = Rummage.findSmartStackToAllButton(self)
  if (smartStackButton ~= nil) then
    result = smartStackButton:getRight() + 3
  end
  return result
end

-- Update the button
function Rummage.updateUnpackItemsButton(self)
  if not self.onCharacter and self.RummageUnpackItems ~= nil then
    
    self.RummageUnpackItems:setVisible(Rummage.showButton(self))
        
    local textIndex = Rummage.whichText(self.inventory:getType())
    local title = Rummage.UI[textIndex]
    local tooltip = Rummage.UI_TOOLTIP[textIndex]
        
    local offset = Rummage.getUnpackButtonOffset(self)
    self.RummageUnpackItems:setX(offset)
    
    self.RummageUnpackItems:setTitle(title)

    if (self.RummageUnpackItems.tooltipUI ~= nil) then
      self.RummageUnpackItems.tooltipUI:setName(tooltip)
    end
    
    local mouseOver = self.RummageUnpackItems:isMouseOver()
    if mouseOver and self.RummageUnpackItemsTooltip == false then
        self.RummageUnpackItemsTooltip = true  
    elseif mouseOver == false then
        self.RummageUnpackItemsTooltip = false
    end
  end
end

-- reference to original function
local ISInventoryPagePrerender = ISInventoryPage.prerender

-- Override ISInventoryPage:prerender to inject Rummage code to update buttons
function ISInventoryPage:prerender()
  ISInventoryPagePrerender(self) -- call original function
  pcall(Rummage.updateUnpackItemsButton, self) -- pcall to prevent UI from crashing if this mod causes problems
  pcall(Rummage.createUnpackItemsButton, self) -- in case other mods override ISInventoryPage.createChildren - lets try to create buttons
end