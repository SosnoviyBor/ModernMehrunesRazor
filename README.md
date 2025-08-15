# Modern Mehrunes' Razor (OpenMW)

Adds an instakill chance to Mehrunes' Razor. Daedric Banishing style.

Let's be honest: does anyone like vanilla Mehrunes' Razor? Me neither. In my opinion, Daedric artifacts should be unique and memorable, and later games really nailed it. That's why I'm presenting a Daedric artifact _worthy_ of the name of the Prince of Destruction himself!

## Features

### Presets (in %)

- **Oblivion** -> `PlayerLuck * 0.05`
- **Skyrim** -> `2 / 101` (≈ 1.98%)
- **Custom** -> `BaseChance + PlayerLuck * LuckModifier`
- **Cheater** -> yes

### Enemy Luck Counters

Optionally adds `(-EnemyLuck * EnemyLuckModifier)` to the end of the equation.  
Fully toggleable and configurable.

### Special Effects!

Not really - just a pop-up message like in Oblivion and the vanilla critical hit SFX on instakill.  
All toggleable.

### Essential NPCs Blacklist

The blade will not instakill NPCs who are considered Essential - crucial to the completion of the Main Quest.  
A full list can be found on UESP.

My personal changes to the list:

- Added **Dagoth Ur** (phase 2)
- Added **Heart of Lorkhan**
- Removed **Crazy Batou** _(Bethesda blunder)_
- Removed **Goris the Maggot King** _(Bethesda blunder)_
- Removed **Luven** _(Bethesda blunder)_

## Requirements

OpenMW July 2025 dev build or newer (API version 87+).

## Installation

Installs like any other OpenMW mod.

An optional `.omwaddon` is included to remove all enchantments from Mehrunes' Razor.

## Compatibility

Yes.

## Other cool Mehrunes' Razor mods

These may not work perfectly with this mod, but they're still worth checking out:

- [Artifacts Reworked Constant Effect and Other Changes](https://www.nexusmods.com/morrowind/mods/56702) by WezKal – Turns the Razor into a glass-cannon weapon: guaranteed instakill, but it consumes a lot of souls to recharge.