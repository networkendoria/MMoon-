# MMoon

**MMoon** is an original 2D rhythm-horror game by Zyven Studios.

MMoon takes inspiration from lane-based rhythm gameplay while developing its own rhythm logic, characters, world, soundtrack, charts, and visual identity. It does not use Psych Engine or another prebuilt FNF engine.

## Direction
- First platform: Android
- Orientation: landscape
- Framework: HaxeFlixel + OpenFL + Lime
- Custom systems: rhythm clock, charts, note judgement, scoring, input, and content pipeline
- Visual direction: dark atmospheric horror, unsettling environments, cyan/blue highlights
- Initial logical resolution: 1280×720 at 60 FPS

## Status
Stage 0 — project foundation. The current boot screen is temporary.

## Structure
- `source/core` — shared runtime systems
- `source/states` — game screens
- `source/rhythm` — BPM, timing, charts, scoring
- `source/notes` — notes and judgement
- `source/characters` — character data and animation
- `source/audio` — music and sound
- `source/ui` — menus and HUD
- `source/input` — touch and keyboard input
- `source/save` — settings and save data
- `assets` — original/licensed art, audio, fonts, effects
- `data` — charts and content definitions

All shipped art, music, and character designs will be original or appropriately licensed.
