
local ADDON, UPA = ...

local FirstAid = {
    profession = "First Aid",
    recipes = {
        { name = "Linen Bandage", itemId = 1251,
          skillRange = { orange = 1, yellow = 40, green = 50, gray = 75 },
          materials = { ["Linen Cloth"] = 1 },
          materialIds = { ["Linen Cloth"] = 2589 },
          trainingCost = "00g 00s 10c",
          vendorValue = "00g 00s 10c",
          source = "Train"
        },
        { name = "Heavy Linen Bandage", itemId = 2581,
          skillRange = { orange = 40, yellow = 50, green = 75, gray = 100 },
          materials = { ["Linen Cloth"] = 2 },
          materialIds = { ["Linen Cloth"] = 2589 },
          trainingCost = "00g 00s 50c",
          vendorValue = "00g 00s 20c",
          source = "Train"
        },
        { name = "Wool Bandage", itemId = 3530,
          skillRange = { orange = 80, yellow = 115, green = 140, gray = 160 },
          materials = { ["Wool Cloth"] = 1 },
          materialIds = { ["Wool Cloth"] = 2592 },
          trainingCost = "00g 01s 00c",
          vendorValue = "00g 00s 28c",
          source = "Train"
        },
        { name = "Heavy Wool Bandage", itemId = 3531,
          skillRange = { orange = 115, yellow = 150, green = 175, gray = 190 },
          materials = { ["Wool Cloth"] = 2 },
          materialIds = { ["Wool Cloth"] = 2592 },
          trainingCost = "00g 01s 50c",
          vendorValue = "00g 00s 57c",
          source = "Train"
        },
        { name = "Silk Bandage", itemId = 6450,
          skillRange = { orange = 150, yellow = 180, green = 210, gray = 225 },
          materials = { ["Silk Cloth"] = 1 },
          materialIds = { ["Silk Cloth"] = 4306 },
          trainingCost = "00g 02s 00c",
          vendorValue = "00g 02s 00c",
          source = "Train"
        },
        { name = "Heavy Silk Bandage", itemId = 6451,
          skillRange = { orange = 180, yellow = 210, green = 240, gray = 260 },
          materials = { ["Silk Cloth"] = 2 },
          materialIds = { ["Silk Cloth"] = 4306 },
          trainingCost = "00g 02s 50c",
          vendorValue = "00g 04s 00c",
          source = "Train"
        },
        { name = "Mageweave Bandage", itemId = 8544,
          skillRange = { orange = 210, yellow = 240, green = 270, gray = 290 },
          materials = { ["Mageweave Cloth"] = 1 },
          materialIds = { ["Mageweave Cloth"] = 4338 },
          trainingCost = "00g 03s 00c",
          vendorValue = "00g 04s 00c",
          source = "Train"
        },
        { name = "Heavy Mageweave Bandage", itemId = 8545,
          skillRange = { orange = 240, yellow = 270, green = 290, gray = 300 },
          materials = { ["Mageweave Cloth"] = 2 },
          materialIds = { ["Mageweave Cloth"] = 4338 },
          trainingCost = "00g 03s 50c",
          vendorValue = "00g 06s 00c",
          source = "Train"
        },
        { name = "Runecloth Bandage", itemId = 14529,
          skillRange = { orange = 260, yellow = 290, green = 310, gray = 330 },
          materials = { ["Runecloth"] = 1 },
          materialIds = { ["Runecloth"] = 14047 },
          trainingCost = "00g 04s 00c",
          vendorValue = "00g 05s 00c",
          source = "Train"
        },
        { name = "Heavy Runecloth Bandage", itemId = 14530,
          skillRange = { orange = 290, yellow = 320, green = 340, gray = 360 },
          materials = { ["Runecloth"] = 2 },
          materialIds = { ["Runecloth"] = 14047 },
          trainingCost = "00g 05s 00c",
          vendorValue = "00g 10s 00c",
          source = "Train"
        },
        -- Anti-venoms (Classic)
        { name = "Anti-Venom", itemId = 6452,
          skillRange = { orange = 80, yellow = 115, green = 135, gray = 155 },
          materials = { ["Small Venom Sac"] = 1 },
          materialIds = { ["Small Venom Sac"] = 1475 },
          trainingCost = "Recipe: Anti-Venom",
          vendorValue = "00g 00s 00c",
          source = "Buy recipe"
        },
        { name = "Strong Anti-Venom", itemId = 6453,
          skillRange = { orange = 130, yellow = 155, green = 175, gray = 195 },
          materials = { ["Large Venom Sac"] = 1 },
          materialIds = { ["Large Venom Sac"] = 1288 },
          trainingCost = "Recipe: Strong Anti-Venom",
          vendorValue = "00g 00s 00c",
          source = "Buy recipe"
        },
    }
}

UPA:RegisterProfession(FirstAid)
