execute store result storage scrfx:zinternals temp.to_run_callback.player_id int 1 run scoreboard players get @s scrfx.zinternals.player_id
data modify storage scrfx:zinternals temp.to_run_callback.frame set value "middle"
function scrfx:zinternals/run_callback with storage scrfx:zinternals temp.to_run_callback
