Rummage = Rummage or {}
Rummage.Options = Rummage.Options or {}

Rummage.Options.lookFor1 = 46
Rummage.AllCat = {
  getText("IGUI_ItemCat_Accessory"), --= "Accessory", 1
  getText("IGUI_ItemCat_Ammo"), --= "Ammo", 2
  getText("IGUI_ItemCat_Appearance"), --= "Appearance", 3
  getText("IGUI_ItemCat_Badger"), --= "Badger", 4
  getText("IGUI_ItemCat_Bag"), --= "Bag", 5
  getText("IGUI_ItemCat_Bandage"), --= "Bandage", 6
  getText("IGUI_ItemCat_Beaver"), --= "Beaver", 7
  getText("IGUI_ItemCat_Bunny"), --= "Bunny", 8
  getText("IGUI_ItemCat_Camping"), --= "Camping", 9
  getText("IGUI_ItemCat_Cartography"), --= "Cartography", 10
  getText("IGUI_ItemCat_Clothing"), --= "Clothing", 11
  getText("IGUI_ItemCat_Communications"), --= "Communications", 12
  getText("IGUI_ItemCat_Container"), --= "Container", 13
  getText("IGUI_ItemCat_Cooking"), --= "Cooking", 14
  --getText("IGUI_ItemCat_Corpse"), --= "Corpse",
  getText("IGUI_ItemCat_Devices"), --= "Devices", 15
  getText("IGUI_ItemCat_Electronics"), --= "Electronics", 16
  getText("IGUI_ItemCat_Entertainment"), --= "Entertainment", 17
  getText("IGUI_ItemCat_Explosives"), --= "Explosives", 18
  getText("IGUI_ItemCat_FirstAid"), --= "First Aid", 19
  getText("IGUI_ItemCat_Fishing"), --= "Fishing", 20
  getText("IGUI_ItemCat_Food"), --= "Food", 21
  getText("IGUI_ItemCat_Fox"), --= "Fox", 22
  getText("IGUI_ItemCat_Furniture"), --= "Furniture", 23
  getText("IGUI_ItemCat_Gardening"), --= "Gardening", 24
  getText("IGUI_ItemCat_Hedgehog"), --= "Hedgehog", 25
  --getText("IGUI_ItemCat_Hidden"), --= "Hidden",
  getText("IGUI_ItemCat_Household"), --= "Household", 26
  getText("IGUI_ItemCat_Instrument"), --= "Instrument", 27
  getText("IGUI_ItemCat_Junk"), --= "Junk", 28
  getText("IGUI_ItemCat_LightSource"), --= "Light Source", 29
  getText("IGUI_ItemCat_Literature"), --= "Literature", 30
  getText("IGUI_ItemCat_MakeUp"), --= "Makeup", 31
  getText("IGUI_ItemCat_Material"), --= "Material", 32
  getText("IGUI_ItemCat_Mole"), --= "Mole", 33
  getText("IGUI_ItemCat_Paint"), --= "Paint", 34
  getText("IGUI_ItemCat_Raccoon"), --= "Raccoon", 35
  getText("IGUI_ItemCat_Security"), --= "Security", 36
  getText("IGUI_ItemCat_SkillBook"), --= "Skill Book", 37
  getText("IGUI_ItemCat_Sports"), --= "Sports", 38
  getText("IGUI_ItemCat_Squirrel"), --= "Squirrel", 39
  getText("IGUI_ItemCat_Tool"), --= "Tool", 40
  getText("IGUI_ItemCat_ToolWeapon"), --= "Tool / Weapon", 41
  getText("IGUI_ItemCat_Trapping"), --= "Trapping", 42
  getText("IGUI_ItemCat_VehicleMaintenance"), --= "Vehicle Maintenance", 43
  getText("IGUI_ItemCat_Water"), --= "Water", 44
  getText("IGUI_ItemCat_WaterContainer"), --= "Water Container", 45
  getText("IGUI_ItemCat_Weapon"), --= "Weapon", 46
  getText("IGUI_ItemCat_WeaponCrafted"), --= "Weapon - Crafted", 47
  getText("IGUI_ItemCat_WeaponPart"), --= "Weapon Part", 48
  --getText("IGUI_ItemCat_Wound"), --= "Wound",
  --getText("IGUI_ItemCat_ZedDmg"), --= "ZedDmg",
  }

if ModOptions and ModOptions.getInstance then

  local function onModOptionsApply(optionValues)
    Rummage.Options.lookFor1 = optionValues.settings.options.lookFor1
  end
    
  local SETTINGS = {
    options_data = {
      lookFor1 = {
          getText("IGUI_ItemCat_Accessory"), --= "Accessory", 1
          getText("IGUI_ItemCat_Ammo"), --= "Ammo", 2
          getText("IGUI_ItemCat_Appearance"), --= "Appearance", 3
          getText("IGUI_ItemCat_Badger"), --= "Badger", 4
          getText("IGUI_ItemCat_Bag"), --= "Bag", 5
          getText("IGUI_ItemCat_Bandage"), --= "Bandage", 6
          getText("IGUI_ItemCat_Beaver"), --= "Beaver", 7
          getText("IGUI_ItemCat_Bunny"), --= "Bunny", 8
          getText("IGUI_ItemCat_Camping"), --= "Camping", 9
          getText("IGUI_ItemCat_Cartography"), --= "Cartography", 10
          getText("IGUI_ItemCat_Clothing"), --= "Clothing", 11
          getText("IGUI_ItemCat_Communications"), --= "Communications", 12
          getText("IGUI_ItemCat_Container"), --= "Container", 13
          getText("IGUI_ItemCat_Cooking"), --= "Cooking", 14
          --getText("IGUI_ItemCat_Corpse"), --= "Corpse",
          getText("IGUI_ItemCat_Devices"), --= "Devices", 15
          getText("IGUI_ItemCat_Electronics"), --= "Electronics", 16
          getText("IGUI_ItemCat_Entertainment"), --= "Entertainment", 17
          getText("IGUI_ItemCat_Explosives"), --= "Explosives", 18
          getText("IGUI_ItemCat_FirstAid"), --= "First Aid", 19
          getText("IGUI_ItemCat_Fishing"), --= "Fishing", 20
          getText("IGUI_ItemCat_Food"), --= "Food", 21
          getText("IGUI_ItemCat_Fox"), --= "Fox", 22
          getText("IGUI_ItemCat_Furniture"), --= "Furniture", 23
          getText("IGUI_ItemCat_Gardening"), --= "Gardening", 24
          getText("IGUI_ItemCat_Hedgehog"), --= "Hedgehog", 25
          --getText("IGUI_ItemCat_Hidden"), --= "Hidden",
          getText("IGUI_ItemCat_Household"), --= "Household", 26
          getText("IGUI_ItemCat_Instrument"), --= "Instrument", 27
          getText("IGUI_ItemCat_Junk"), --= "Junk", 28
          getText("IGUI_ItemCat_LightSource"), --= "Light Source", 29
          getText("IGUI_ItemCat_Literature"), --= "Literature", 30
          getText("IGUI_ItemCat_MakeUp"), --= "Makeup", 31
          getText("IGUI_ItemCat_Material"), --= "Material", 32
          getText("IGUI_ItemCat_Mole"), --= "Mole", 33
          getText("IGUI_ItemCat_Paint"), --= "Paint", 34
          getText("IGUI_ItemCat_Raccoon"), --= "Raccoon", 35
          getText("IGUI_ItemCat_Security"), --= "Security", 36
          getText("IGUI_ItemCat_SkillBook"), --= "Skill Book", 37
          getText("IGUI_ItemCat_Sports"), --= "Sports", 38
          getText("IGUI_ItemCat_Squirrel"), --= "Squirrel", 39
          getText("IGUI_ItemCat_Tool"), --= "Tool", 40
          getText("IGUI_ItemCat_ToolWeapon"), --= "Tool / Weapon", 41
          getText("IGUI_ItemCat_Trapping"), --= "Trapping", 42
          getText("IGUI_ItemCat_VehicleMaintenance"), --= "Vehicle Maintenance", 43
          getText("IGUI_ItemCat_Water"), --= "Water", 44
          getText("IGUI_ItemCat_WaterContainer"), --= "Water Container", 45
          getText("IGUI_ItemCat_Weapon"), --= "Weapon", 46
          getText("IGUI_ItemCat_WeaponCrafted"), --= "Weapon - Crafted", 47
          getText("IGUI_ItemCat_WeaponPart"), --= "Weapon Part", 48
          --getText("IGUI_ItemCat_Wound"), --= "Wound",
          --getText("IGUI_ItemCat_ZedDmg"), --= "ZedDmg",
  
        name = "UI_RO_LOOK_FOR_1",
        tooltip = "UI_RO_LOOK_FOR_1_TT",
        default = 46,
        OnApplyMainMenu = onModOptionsApply,
        OnApplyInGame = onModOptionsApply,
      },
    },

    mod_id = 'Rummage',
    mod_shortname = 'Rummage',
    mod_fullname = 'Rummage',
  }

    local optionsInstance = ModOptions:getInstance(SETTINGS)
    ModOptions:loadFile()

    --GM.init()

    Events.OnPreMapLoad.Add(function() onModOptionsApply({ settings = SETTINGS }) end)
end