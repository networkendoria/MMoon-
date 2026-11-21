# MMoon — Friday Night Funkin' Mod

MMoon is an original rhythm-horror mod project for **Psych Engine 0.7.3**.

## Install
1. Use a Psych Engine 0.7.3 build.
2. Copy the `MMoon` folder into the game's `mods` directory.
3. Add the song audio files described below.
4. Launch the game and load the `moonlit` chart through the chart editor / Freeplay workflow.

## Current prototype contents
- `data/moonlit/moonlit.json`: first chart draft.
- `data/moonlit/modchart.lua`: intro text, camera pressure, pulse and note-hit feedback.
- `stages/abyss.lua`: procedural dark stage made from engine sprites and gradients.
- `pack.json`: mod metadata.

## Audio still required
Place original audio files here:
- `songs/moonlit/Inst.ogg`
- `songs/moonlit/Voices.ogg` (optional; chart currently has no vocal requirement)

The repository does not yet contain a finished recording, character sprite sheets, or a compiled ZIP release. Those assets must be added before this becomes a complete playable song. Do not use copyrighted FNF songs or other creators' assets.

## Controls
Use the standard Psych Engine controls. The chart is a four-lane prototype and uses the default Boyfriend/Dad characters until custom sprite sheets are added.

## Compatibility
Target: Psych Engine 0.7.3 (Lua mod folder format). Other forks may require small API or metadata adjustments.
