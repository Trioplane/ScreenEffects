execute unless score .loaded scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
execute if score .loaded scrfx.zinternals.globals matches 1 if score .dev_mode scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
# Put your screen effects here.
#
# "ns:identifier" - The identifier of the screen effect, the namespace is optional but recommended to be compatible with other packs.
# `tps` - The frametime / fps of the screen effect, but in ticks. (1 second = 20 ticks)
# `frame_count` - How much frames the screen effect has.
# `path` - The resource path of the font file with the number at the end omitted.
data modify storage scrfx:registry screen_effects merge value {"trplnr:test": {tps: 20, frame_count: 5, path: "trplnr:scrfx/test"}}
