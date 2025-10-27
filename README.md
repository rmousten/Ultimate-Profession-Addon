# Ultimate-Profession-Addon
A addon with a database and scan feature to make the most optimal path to level your profession

# Ultimate Profession Guide

This addon helps optimize profession leveling by scanning through **TSM** and **Auctionator** data.

## Database Structure
Professions → Recipes (trainer/AH price) → Materials


### Professions that will be supported
- Blacksmithing (BS)  
- Leatherworking (LW)  
- Tailoring  
- Engineering  
- Enchanting  
- Cooking  
- First Aid  

---

## Leveling Formula
(cost × skillup%) + ((learncost or Recipe AH cost) / skillavail) – (disenchant value OR vendor value)


- If **disenchant value > vendor value**, use Disenchant.  
- First iteration does **not** include disenchant value.  
- Disenchanting is search-based on materials and uses disenchant tables for all item levels:  
  [Disenchanting Tables – WoW Professions](https://www.wow-professions.com/tbc/disenchanting-tables)

---

## Development Roadmap

### 1. First Aid Database
- Recipes / training cost  
- Average cost per level  
- Vendor value  
- No disenchant  

### 2. Cooking Database
- Similar to First Aid, but larger dataset  
- Recipe costs include AH prices  

### 3. First Crafting Profession
- Any crafting profession (not Enchanting)  
- Start with vendor value  
- Introduce disenchant value  

### 4. Remaining Crafting Professions

### 5. Enchanting
- More complex since DE is possible for many early levels  
- Possibly delay until TBC release  

## Features

- 📚 Database with all crafts  
- 🔍 Full AH scan / profession-relevant AH scan  
- ✨ AH scan of enchanting mats to calculate DE value using DE tables  
- 📈 Calculates best path based on:
- Cost of mats + training + recipe – Disenchant value – Vendor value
- 💰 Displays RAW price vs. Disenchant + Vendor value   
