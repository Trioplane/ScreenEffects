execute unless score .loaded scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
data modify storage scrfx:registry screen_effects merge value { \
    "trplnr:test": { frametime: 2, frames: 5, path: "trplnr:font/scrfx/test" }, \
}

data modify storage scrfx:registry screen_effects merge value { \
    "trplnr:test2": { frametime: 2, frames: 5, path: "trplnr:font/scrfx/test" }, \
}