execute unless score .loaded scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
execute if score .loaded scrfx.zinternals.globals matches 1 if score .dev_mode scrfx.zinternals.globals matches 1 run data remove storage scrfx:registry screen_effects
# Put your screen effects here.
#
# "ns:identifier" - The identifier of the screen effect, the namespace is optional but recommended to be compatible with other packs.
# `tps` - The frametime / fps of the screen effect, but in ticks. (1 second = 20 ticks)
# `frame_count` - How much frames the screen effect has.
# `middle.frame` - Points to what frame the declared 'middle' is. This is useful for transition animations like tping the player when the screen is fully covered.
# `middle.callback` - The command to run when the 'middle' frame is ran.
# `end.callback` - The command to run when the 'end' frame is ran. This does not have a 'frame' property, this already runs once the animation ends.
# `path` - The resource path of the font file with the number at the end omitted.
data modify storage scrfx:registry screen_effects merge value {"examples:toast": {tps: 1, frame_count: 31, path: "example:scrfx/exampletoast"}, "examples:amongus": {tps: 1, frame_count: 24, middle: {frame: 12, callback: "kill @s"}, path: "example:scrfx/exampleamongus"}, "examples:trophy": {tps: 1, frame_count: 46, path: "example:scrfx/exampletrophy"}, "examples:transition": {tps: 1, frame_count: 69, middle: {frame: 26, callback: "say This frame covers the whole screen"}, path: "example:scrfx/exampletransition"}}
