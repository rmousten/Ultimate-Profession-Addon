
UltimateProfessionAddon (First Aid + Auctionator)
=================================================

This addon adds a Calculate button to the First Aid profession window, computes a price-aware, greedy leveling path using Auctionator prices, and shows a Shopping List of all mats.

Install
-------
1) Close the game.
2) Unzip to: Interface/AddOns/UltimateProfessionAddon/
3) Ensure Auctionator is enabled.
4) Launch / reload.

Use
---
- Open First Aid → click Calculate.
- Use Previous / Next to browse steps pages.

Notes
-----
- Pricing uses Auctionator's last-known data. Open the AH to refresh.
- Eligibility: a recipe is considered only once your skill has reached its orange threshold.
- Decision rule: per-skill = (mat - vendor) / p + (learn / skillAvail), with p = 1.0/0.5/0.2/0.0 for orange/yellow/green/gray.
