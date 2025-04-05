function scrfx:zinternals/initialize/scoreboards
function scrfx:registry
scoreboard players set .loaded scrfx.zinternals.globals 1
execute if score .dev_mode scrfx.zinternals.globals matches 1 run say Reloaded.
