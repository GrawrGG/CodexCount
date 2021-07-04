local ADDON_NAME = ...
local logger = CodexCountLogger
local CCEvents = CreateFrame("FRAME", ADDON_NAME)

local currentCount = 0

local CCLDB =
  LibStub("LibDataBroker-1.1"):NewDataObject(
  ADDON_NAME,
  {
    type = "data source",
    text = ADDON_NAME,
    label = ADDON_NAME,
    icon = "Interface\\Icons\\inv_relics_6orunestone_ogremissive",
    OnTooltipShow = function(tooltip)
      if (not tooltip or not tooltip.AddLine) then
        return
      end
      local expectedRep = floor(currentCount / 2)
      tooltip:AddLine("|cFFFFFFFF" .. ADDON_NAME .. "|r")
      tooltip:AddLine("You have " .. currentCount .. " Cataloged Research, worth " .. expectedRep .. " reputation.")
    end
  }
)
local CCIcon = LibStub("LibDBIcon-1.0")

-- Map of item ID to their Cataloged Research value
local ITEM_VALUES = {
  [186685] = 1, -- Relic Fragment
  [187322] = 8, -- Crumbling Stone Tablet
  [187457] = 8, -- Engraved Glass Pane
  [187324] = 8, -- Gnawed Ancient Idol
  [187323] = 8, -- Runic Diagram
  [187460] = 8, -- Strangely Intricate Key
  [187458] = 8, -- Unearthed Teleporter Sigil
  [187459] = 8, -- Vial of Mysterious Liquid
  [187465] = 48, -- Complicated Organism Harmonizer
  [187327] = 48, -- Encrypted Korthian Journal
  [187463] = 48, -- Enigmatic Map Fragments
  [187325] = 48, -- Faded Razorwing Anatomy Illustration
  [187326] = 48, -- Half-Completed Runeforge Pattern
  [187462] = 48, -- Scroll of Shadowlands Fables
  [187478] = 48, -- White Razorwing Talon
  [187336] = 100, -- Forbidden Weapon Schematics
  [187466] = 100, -- Korthian Cypher Book
  [187332] = 100, -- Recovered Page of Voices
  [187328] = 100, -- Ripped Cosmology Chart
  [187334] = 100, -- Shattered Void Tablet
  [187330] = 150, -- Naaru Shard Fragment
  [187329] = 150, -- Old God Specimen Jar
  [187467] = 150, -- Perplexing Rune-Cube
  [187331] = 150, -- Tattered Fae Designs
  [187311] = 300, -- Azgoth's Tattered Maps
  [187333] = 300, -- Core of an Unknown Titan
  [187350] = 300, -- Displaced Relic
  [187335] = 300 -- Maldraxxus Larva Shell
}

local function OnBagUpdated()
  local count = 0
  for bag = 0, NUM_BAG_SLOTS do
    for slot = 1, GetContainerNumSlots(bag) do
      local itemId = GetContainerItemID(bag, slot)
      local itemValue = ITEM_VALUES[itemId]
      if (itemValue) then
        local _, itemCount = GetContainerItemInfo(bag, slot)
        count = count + itemValue * itemCount
      end
    end
  end
  logger.log("Updated count: " .. count)
  currentCount = count
end

local function OnAddonLoaded(addonName)
  if (addonName == ADDON_NAME) then
    CCEvents:UnregisterEvent("ADDON_LOADED")
    CCEvents:RegisterEvent("BAG_UPDATE")
  end
end

local function HandleEvent(_, event, ...)
  logger.log("Handling event " .. event)
  if (event == "ADDON_LOADED") then
    OnAddonLoaded(...)
  elseif (event == "BAG_UPDATE") then
    OnBagUpdated()
  end
end

local function Init()
  if (CCMinimapIcon == nil) then
    CCMinimapIcon = {}
  end
  CCIcon:Register(ADDON_NAME, CCLDB, CCMinimapIcon)
  CCEvents:SetScript("OnEvent", HandleEvent)
  CCEvents:RegisterEvent("ADDON_LOADED")
end

logger.log("Loading...")

Init()
