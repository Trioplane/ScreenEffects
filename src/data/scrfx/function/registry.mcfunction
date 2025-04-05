# DO NOT TOUCH THIS
execute unless score .loaded scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
execute if score .loaded scrfx.zinternals.globals matches 1 if score .dev_mode scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
# -----------------

raw f"# Put your screen effects here."
raw f"#"
raw f"# \"ns:identifier\" - The identifier of the screen effect, the namespace is optional but recommended to be compatible with other packs."
raw f"# `tps` - The frametime / fps of the screen effect, but in ticks. (1 second = 20 ticks)"
raw f"# `frame_count` - How much frames the screen effect has."
raw f"# `path` - The resource path of the font file with the number at the end omitted."

data modify storage scrfx:registry screen_effects merge value { \
    "trplnr:test": { tps: 20, frame_count: 5, path: "trplnr:scrfx/test" }, \
    "trplnr:draw_transition": { tps: 1, frame_count: 19, middle: { frame: 10 }, end: { callback: "say end" }, path: "trplnr:scrfx/draw_transition" }, \
}