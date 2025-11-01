local Blacksmithing = {
  profession = "Blacksmithing",
  recipes = {
    {
      name = "Copper Bracers", itemId = 2854,
      skillRange = { orange = 1, yellow = 20, green = 40, gray = 60 },
      materials = { ["Copper Bar"] = 2 },
      materialIds = { ["Copper Bar"] = 2840 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Copper Vest", itemId = 10421,
      skillRange = { orange = 1, yellow = 15, green = 35, gray = 55 },
      materials = { ["Copper Bar"] = 4 },
      materialIds = { ["Copper Bar"] = 2840 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Sharpening Stone", itemId = 2862,
      skillRange = { orange = 1, yellow = 15, green = 35, gray = 55 },
      materials = { ["Rough Stone"] = 1 },
      materialIds = { ["Rough Stone"] = 2835 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Weightstone", itemId = 3239,
      skillRange = { orange = 1, yellow = 15, green = 35, gray = 55 },
      materials = { ["Rough Stone"] = 1 },
      materialIds = { ["Rough Stone"] = 2835 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Chain Pants", itemId = 2852,
      skillRange = { orange = 1, yellow = 50, green = 70, gray = 90 },
      materials = { ["Copper Bar"] = 4 },
      materialIds = { ["Copper Bar"] = 2840 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Mace", itemId = 2848,
      skillRange = { orange = 15, yellow = 55, green = 75, gray = 95 },
      materials = { ["Copper Bar"] = 6, ["Weak Flux"] = 1 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Chain Boots", itemId = 2853,
      skillRange = { orange = 20, yellow = 60, green = 80, gray = 100 },
      materials = { ["Copper Bar"] = 8, ["Weak Flux"] = 1 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Axe", itemId = 2845,
      skillRange = { orange = 20, yellow = 60, green = 80, gray = 100 },
      materials = { ["Copper Bar"] = 6, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Shortsword", itemId = 2847,
      skillRange = { orange = 25, yellow = 65, green = 85, gray = 105 },
      materials = { ["Copper Bar"] = 6, ["Rough Grinding Stone"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Rough Grinding Stone"] = 3470 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Dagger", itemId = 7166,
      skillRange = { orange = 30, yellow = 70, green = 90, gray = 110 },
      materials = { ["Copper Bar"] = 6, ["Weak Flux"] = 1 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Claymore", itemId = 7955,
      skillRange = { orange = 30, yellow = 70, green = 90, gray = 110 },
      materials = { ["Copper Bar"] = 10, ["Weak Flux"] = 1 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Chain Belt", itemId = 2851,
      skillRange = { orange = 35, yellow = 75, green = 95, gray = 115 },
      materials = { ["Copper Bar"] = 2 },
      materialIds = { ["Copper Bar"] = 2840 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Copper Battle Axe", itemId = 2849,
      skillRange = { orange = 35, yellow = 75, green = 95, gray = 115 },
      materials = { ["Copper Bar"] = 12, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Runed Copper Gauntlets", itemId = 3472,
      skillRange = { orange = 40, yellow = 80, green = 100, gray = 120 },
      materials = { ["Copper Bar"] = 8, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Runed Copper Pants", itemId = 3473,
      skillRange = { orange = 45, yellow = 85, green = 105, gray = 125 },
      materials = { ["Copper Bar"] = 8, ["Weak Flux"] = 2, ["Malachite"] = 3 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880, ["Malachite"] = 774 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Gemmed Copper Gauntlets", itemId = 3474,
      skillRange = { orange = 60, yellow = 100, green = 120, gray = 140 },
      materials = { ["Copper Bar"] = 8, ["Weak Flux"] = 2, ["Tigerseye"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880, ["Tigerseye"] = 818 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Coarse Sharpening Stone", itemId = 2863,
      skillRange = { orange = 65, yellow = 65, green = 72, gray = 80 },
      materials = { ["Coarse Stone"] = 1 },
      materialIds = { ["Coarse Stone"] = 2836 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Coarse Weightstone", itemId = 3240,
      skillRange = { orange = 65, yellow = 65, green = 72, gray = 80 },
      materials = { ["Coarse Stone"] = 1 },
      materialIds = { ["Coarse Stone"] = 2836 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Copper Maul", itemId = 6214,
      skillRange = { orange = 65, yellow = 105, green = 125, gray = 145 },
      materials = { ["Copper Bar"] = 12, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Thick War Axe", itemId = 3487,
      skillRange = { orange = 70, yellow = 110, green = 130, gray = 150 },
      materials = { ["Copper Bar"] = 10, ["Silver Bar"] = 2, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Silver Bar"] = 2842, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Runed Copper Belt", itemId = 3471,
      skillRange = { orange = 70, yellow = 110, green = 130, gray = 150 },
      materials = { ["Copper Bar"] = 10, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Coarse Grinding Stone", itemId = 3478,
      skillRange = { orange = 75, yellow = 75, green = 87, gray = 100 },
      materials = { ["Coarse Stone"] = 2 },
      materialIds = { ["Coarse Stone"] = 2836 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Runed Copper Breastplate", itemId = 2866,
      skillRange = { orange = 80, yellow = 120, green = 140, gray = 160 },
      materials = { ["Copper Bar"] = 12, ["Weak Flux"] = 2, ["Shadowgem"] = 1 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880, ["Shadowgem"] = 1210 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Runed Copper Bracers", itemId = 2868,
      skillRange = { orange = 90, yellow = 115, green = 127, gray = 140 },
      materials = { ["Copper Bar"] = 10, ["Weak Flux"] = 3 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Bronze Boots", itemId = 6350,
      skillRange = { orange = 95, yellow = 125, green = 135, gray = 145 },
      materials = { ["Bronze Bar"] = 6 },
      materialIds = { ["Bronze Bar"] = 2841 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Copper Broadsword", itemId = 7956,
      skillRange = { orange = 95, yellow = 135, green = 155, gray = 175 },
      materials = { ["Copper Bar"] = 14, ["Weak Flux"] = 2 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Silver Skeleton Key", itemId = 15869,
      skillRange = { orange = 100, yellow = 105, green = 107, gray = 110 },
      materials = { ["Silver Bar"] = 1, ["Rough Grinding Stone"] = 1 },
      materialIds = { ["Silver Bar"] = 2842, ["Rough Grinding Stone"] = 3470 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Silver Rod", itemId = 6338,
      skillRange = { orange = 100, yellow = 105, green = 107, gray = 110 },
      materials = { ["Silver Bar"] = 2 },
      materialIds = { ["Silver Bar"] = 2842 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Ironforge Breastplate", itemId = 6731,
      skillRange = { orange = 100, yellow = 140, green = 160, gray = 180 },
      materials = { ["Copper Bar"] = 16, ["Weak Flux"] = 3 },
      materialIds = { ["Copper Bar"] = 2840, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Big Bronze Knife", itemId = 3848,
      skillRange = { orange = 105, yellow = 135, green = 150, gray = 165 },
      materials = { ["Bronze Bar"] = 6, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Bronze Leggings", itemId = 2865,
      skillRange = { orange = 105, yellow = 145, green = 160, gray = 175 },
      materials = { ["Bronze Bar"] = 6 },
      materialIds = { ["Bronze Bar"] = 2841 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Bronze Cuirass", itemId = 2864,
      skillRange = { orange = 105, yellow = 145, green = 160, gray = 175 },
      materials = { ["Bronze Bar"] = 10 },
      materialIds = { ["Bronze Bar"] = 2841 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Rough Bronze Shoulders", itemId = 3480,
      skillRange = { orange = 110, yellow = 140, green = 155, gray = 170 },
      materials = { ["Bronze Bar"] = 8, ["Shadowgem"] = 1 },
      materialIds = { ["Bronze Bar"] = 2841, ["Shadowgem"] = 1210 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Pearl-handled Dagger", itemId = 5540,
      skillRange = { orange = 110, yellow = 140, green = 155, gray = 170 },
      materials = { ["Bronze Bar"] = 6, ["Small Lustrous Pearl"] = 1, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Small Lustrous Pearl"] = 5498, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Mace", itemId = 2849,
      skillRange = { orange = 110, yellow = 140, green = 155, gray = 170 },
      materials = { ["Bronze Bar"] = 6, ["Weak Flux"] = 4 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Axe", itemId = 2845,
      skillRange = { orange = 115, yellow = 145, green = 160, gray = 175 },
      materials = { ["Bronze Bar"] = 7, ["Weak Flux"] = 4 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Patterned Bronze Bracers", itemId = 2854,
      skillRange = { orange = 120, yellow = 150, green = 165, gray = 180 },
      materials = { ["Bronze Bar"] = 5, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Shortsword", itemId = 2847,
      skillRange = { orange = 120, yellow = 150, green = 165, gray = 180 },
      materials = { ["Bronze Bar"] = 5, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Copper Maul", itemId = 6214,
      skillRange = { orange = 125, yellow = 125, green = 137, gray = 150 },
      materials = { ["Heavy Stone"] = 3 },
      materialIds = { ["Heavy Stone"] = 2838 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Sharpening Stone", itemId = 2871,
      skillRange = { orange = 125, yellow = 125, green = 132, gray = 140 },
      materials = { ["Heavy Stone"] = 1 },
      materialIds = { ["Heavy Stone"] = 2838 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Weightstone", itemId = 3241,
      skillRange = { orange = 125, yellow = 125, green = 132, gray = 140 },
      materials = { ["Heavy Stone"] = 1 },
      materialIds = { ["Heavy Stone"] = 2838 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Warhammer", itemId = 7956,
      skillRange = { orange = 125, yellow = 155, green = 170, gray = 185 },
      materials = { ["Bronze Bar"] = 8, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Bronze Mace", itemId = 3852,
      skillRange = { orange = 130, yellow = 160, green = 175, gray = 190 },
      materials = { ["Bronze Bar"] = 8, ["Moss Agate"] = 1, ["Shadowgem"] = 1, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Moss Agate"] = 1206, ["Shadowgem"] = 1210, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Silvered Bronze Boots", itemId = 3482,
      skillRange = { orange = 130, yellow = 160, green = 175, gray = 190 },
      materials = { ["Bronze Bar"] = 6, ["Silver Bar"] = 2, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Silver Bar"] = 2842, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Greatsword", itemId = 3855,
      skillRange = { orange = 130, yellow = 160, green = 175, gray = 190 },
      materials = { ["Bronze Bar"] = 12, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Silvered Bronze Gauntlets", itemId = 3483,
      skillRange = { orange = 135, yellow = 165, green = 180, gray = 195 },
      materials = { ["Bronze Bar"] = 8, ["Silver Bar"] = 2, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Silver Bar"] = 2842, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Bronze Battle Axe", itemId = 3851,
      skillRange = { orange = 135, yellow = 165, green = 180, gray = 195 },
      materials = { ["Bronze Bar"] = 14, ["Weak Flux"] = 2 },
      materialIds = { ["Bronze Bar"] = 2841, ["Weak Flux"] = 2880 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Shining Silver Breastplate", itemId = 2870,
      skillRange = { orange = 145, yellow = 175, green = 190, gray = 205 },
      materials = { ["Bronze Bar"] = 20, ["Moss Agate"] = 2, ["Small Lustrous Pearl"] = 2, ["Silver Bar"] = 4 },
      materialIds = { ["Bronze Bar"] = 2841, ["Moss Agate"] = 1206, ["Small Lustrous Pearl"] = 5498, ["Silver Bar"] = 2842 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Golden Skeleton Key", itemId = 15870,
      skillRange = { orange = 150, yellow = 150, green = 160, gray = 170 },
      materials = { ["Gold Bar"] = 1, ["Heavy Grinding Stone"] = 1 },
      materialIds = { ["Gold Bar"] = 3577, ["Heavy Grinding Stone"] = 3486 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Golden Rod", itemId = 11128,
      skillRange = { orange = 150, yellow = 155, green = 157, gray = 160 },
      materials = { ["Gold Bar"] = 2, ["Silver Bar"] = 2 },
      materialIds = { ["Gold Bar"] = 3577, ["Silver Bar"] = 2842 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Iron Buckle", itemId = 7071,
      skillRange = { orange = 150, yellow = 152, green = 155, gray = 155 },
      materials = { ["Iron Bar"] = 1 },
      materialIds = { ["Iron Bar"] = 3575 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Green Iron Bracers", itemId = 3835,
      skillRange = { orange = 165, yellow = 180, green = 192, gray = 205 },
      materials = { ["Iron Bar"] = 6, ["Green Dye"] = 1 },
      materialIds = { ["Iron Bar"] = 3575, ["Green Dye"] = 2605 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Green Iron Leggings", itemId = 3842,
      skillRange = { orange = 165, yellow = 180, green = 192, gray = 205 },
      materials = { ["Iron Bar"] = 8, ["Green Dye"] = 2 },
      materialIds = { ["Iron Bar"] = 3575, ["Green Dye"] = 2605 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Green Iron Helm", itemId = 3836,
      skillRange = { orange = 165, yellow = 180, green = 192, gray = 205 },
      materials = { ["Iron Bar"] = 12, ["Heavy Grinding Stone"] = 1, ["Green Dye"] = 2 },
      materialIds = { ["Iron Bar"] = 3575, ["Heavy Grinding Stone"] = 3486, ["Green Dye"] = 2605 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Glinting Steel Dagger", itemId = 3854,
      skillRange = { orange = 180, yellow = 205, green = 217, gray = 230 },
      materials = { ["Steel Bar"] = 10, ["Strong Flux"] = 2, ["Heavy Grinding Stone"] = 1, ["Orange Dye"] = 1 },
      materialIds = { ["Steel Bar"] = 3859, ["Strong Flux"] = 3466, ["Heavy Grinding Stone"] = 3486, ["Orange Dye"] = 6239 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Green Iron Hauberk", itemId = 3844,
      skillRange = { orange = 180, yellow = 205, green = 217, gray = 230 },
      materials = { ["Iron Bar"] = 20, ["Green Dye"] = 4, ["Moss Agate"] = 2 },
      materialIds = { ["Iron Bar"] = 3575, ["Green Dye"] = 2605, ["Moss Agate"] = 1206 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Solid Sharpening Stone", itemId = 7964,
      skillRange = { orange = 200, yellow = 200, green = 205, gray = 210 },
      materials = { ["Solid Stone"] = 1 },
      materialIds = { ["Solid Stone"] = 7912 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Solid Grinding Stone", itemId = 7966,
      skillRange = { orange = 200, yellow = 200, green = 205, gray = 210 },
      materials = { ["Solid Stone"] = 4 },
      materialIds = { ["Solid Stone"] = 7912 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Solid Weightstone", itemId = 7965,
      skillRange = { orange = 200, yellow = 200, green = 205, gray = 210 },
      materials = { ["Solid Stone"] = 1, ["Silk Cloth"] = 1 },
      materialIds = { ["Solid Stone"] = 7912, ["Silk Cloth"] = 4306 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Steel Breastplate", itemId = 7963,
      skillRange = { orange = 200, yellow = 225, green = 237, gray = 250 },
      materials = { ["Steel Bar"] = 16, ["Strong Flux"] = 3 },
      materialIds = { ["Steel Bar"] = 3859, ["Strong Flux"] = 3466 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Truesilver Skeleton Key", itemId = 15871,
      skillRange = { orange = 200, yellow = 210, green = 220, gray = 230 },
      materials = { ["Truesilver Bar"] = 1, ["Solid Grinding Stone"] = 1 },
      materialIds = { ["Truesilver Bar"] = 6037, ["Solid Grinding Stone"] = 7966 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Truesilver Rod", itemId = 11144,
      skillRange = { orange = 200, yellow = 205, green = 207, gray = 210 },
      materials = { ["Truesilver Bar"] = 1, ["Solid Grinding Stone"] = 1 },
      materialIds = { ["Truesilver Bar"] = 6037, ["Solid Grinding Stone"] = 7966 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Golden Scale Bracers", itemId = 6040,
      skillRange = { orange = 185, yellow = 210, green = 222, gray = 235 },
      materials = { ["Steel Bar"] = 5, ["Heavy Grinding Stone"] = 2 },
      materialIds = { ["Steel Bar"] = 3859, ["Heavy Grinding Stone"] = 3486 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Mithril Gauntlet", itemId = 7919,
      skillRange = { orange = 205, yellow = 230, green = 245, gray = 260 },
      materials = { ["Mithril Bar"] = 6, ["Mageweave Cloth"] = 4 },
      materialIds = { ["Mithril Bar"] = 3860, ["Mageweave Cloth"] = 4338 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Mithril Shoulder", itemId = 7918,
      skillRange = { orange = 205, yellow = 230, green = 245, gray = 260 },
      materials = { ["Mithril Bar"] = 8, ["Heavy Leather"] = 6 },
      materialIds = { ["Mithril Bar"] = 3860, ["Heavy Leather"] = 4234 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Mithril Axe", itemId = 7941,
      skillRange = { orange = 210, yellow = 235, green = 247, gray = 260 },
      materials = { ["Mithril Bar"] = 12, ["Truesilver Bar"] = 2, ["Heavy Leather"] = 4 },
      materialIds = { ["Mithril Bar"] = 3860, ["Truesilver Bar"] = 6037, ["Heavy Leather"] = 4234 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Mithril Scale Pants", itemId = 7920,
      skillRange = { orange = 205, yellow = 230, green = 245, gray = 260 },
      materials = { ["Mithril Bar"] = 12 },
      materialIds = { ["Mithril Bar"] = 3860 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Steel Plate Helm", itemId = 7931,
      skillRange = { orange = 215, yellow = 235, green = 245, gray = 255 },
      materials = { ["Steel Bar"] = 14, ["Solid Grinding Stone"] = 2 },
      materialIds = { ["Steel Bar"] = 3859, ["Solid Grinding Stone"] = 7966 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Mithril Boots", itemId = 7933,
      skillRange = { orange = 235, yellow = 255, green = 265, gray = 275 },
      materials = { ["Mithril Bar"] = 14, ["Thick Leather"] = 4 },
      materialIds = { ["Mithril Bar"] = 3860, ["Thick Leather"] = 4304 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Truesilver Gauntlets", itemId = 7938,
      skillRange = { orange = 225, yellow = 245, green = 255, gray = 265 },
      materials = { ["Mithril Bar"] = 10, ["Truesilver Bar"] = 8, ["Aquamarine"] = 3, ["Heavy Leather"] = 3, ["Solid Grinding Stone"] = 2 },
      materialIds = { ["Mithril Bar"] = 3860, ["Truesilver Bar"] = 6037, ["Aquamarine"] = 7909, ["Heavy Leather"] = 4234, ["Solid Grinding Stone"] = 7966 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Big Black Mace", itemId = 7946,
      skillRange = { orange = 230, yellow = 255, green = 267, gray = 280 },
      materials = { ["Mithril Bar"] = 16, ["Black Pearl"] = 4, ["Shadowgem"] = 1, ["Solid Grinding Stone"] = 2 },
      materialIds = { ["Mithril Bar"] = 3860, ["Black Pearl"] = 7971, ["Shadowgem"] = 1210, ["Solid Grinding Stone"] = 7966 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Heavy Mithril Breastplate", itemId = 7935,
      skillRange = { orange = 230, yellow = 250, green = 260, gray = 270 },
      materials = { ["Mithril Bar"] = 16 },
      materialIds = { ["Mithril Bar"] = 3860 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
    {
      name = "Mithril Coif", itemId = 7932,
      skillRange = { orange = 230, yellow = 250, green = 260, gray = 270 },
      materials = { ["Mithril Bar"] = 10, ["Mageweave Cloth"] = 6 },
      materialIds = { ["Mithril Bar"] = 3860, ["Mageweave Cloth"] = 4338 },
      trainingCost = "00g 00s 10c",
      vendorValue = "00g 00s 10c",
      source = "Train"
    },
  {
    name = "Dense Grinding Stone", itemId = 12644,
    skillRange = { orange = 250, yellow = 255, green = 257, gray = 260 },
    materials = { ["Dense Stone"] = 4 },
    materialIds = { ["Dense Stone"] = 12365 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Dense Sharpening Stone", itemId = 12404,
    skillRange = { orange = 250, yellow = 255, green = 257, gray = 260 },
    materials = { ["Dense Stone"] = 1 },
    materialIds = { ["Dense Stone"] = 12365 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Dense Weightstone", itemId = 12643,
    skillRange = { orange = 250, yellow = 255, green = 257, gray = 260 },
    materials = { ["Dense Stone"] = 1, ["Elemental Fire"] = 1 },
    materialIds = { ["Dense Stone"] = 12365, ["Elemental Fire"] = 7068 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Imperial Plate Belt", itemId = 12424,
    skillRange = { orange = 265, yellow = 285, green = 295, gray = 305 },
    materials = { ["Thorium Bar"] = 22, ["Rugged Leather"] = 6, ["Star Ruby"] = 1 },
    materialIds = { ["Thorium Bar"] = 12359, ["Rugged Leather"] = 8170, ["Star Ruby"] = 7910 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Imperial Plate Shoulders", itemId = 12428,
    skillRange = { orange = 265, yellow = 285, green = 295, gray = 305 },
    materials = { ["Thorium Bar"] = 24, ["Rugged Leather"] = 6, ["Citrine"] = 2 },
    materialIds = { ["Thorium Bar"] = 12359, ["Rugged Leather"] = 8170, ["Citrine"] = 3864 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Arcanite Rod", itemId = 16206,
    skillRange = { orange = 275, yellow = 275, green = 280, gray = 285 },
    materials = { ["Arcanite Bar"] = 3 },
    materialIds = { ["Arcanite Bar"] = 12360 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  },
  {
    name = "Arcanite Skeleton Key", itemId = 15872,
    skillRange = { orange = 275, yellow = 275, green = 280, gray = 285 },
    materials = { ["Arcanite Bar"] = 2 },
    materialIds = { ["Arcanite Bar"] = 12360 },
    trainingCost = "00g 00s 10c",
    vendorValue = "00g 00s 10c",
    source = "Train"
  }
}
}
