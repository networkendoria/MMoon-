# Architecture

HaxeFlixel provides the rendering and platform layer. MMoon-specific rhythm gameplay is implemented in this repository; no prebuilt FNF engine is used.

## Runtime flow
1. `Main` creates the Flixel game instance.
2. `BootState` is the temporary startup screen.
3. Menu and gameplay states will live under `source/states`.
4. A custom rhythm clock will own song-time calculations.
5. Chart data will describe note timestamps and lanes independently from rendering.
6. Input events will be judged against chart timestamps using configurable hit windows.

## Constraints
- Chart timing must not depend on frame rate.
- Audio/song position is the gameplay timing reference.
- Touch and keyboard input share one abstraction.
- Chart data is separate from note visuals.
- Effects must be configurable for Android performance.
- Shipped assets must be original or properly licensed.
