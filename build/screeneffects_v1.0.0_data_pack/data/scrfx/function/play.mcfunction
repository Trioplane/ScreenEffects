execute store result storage scrfx:zinternals temp.to_play.player_id int 1 run scoreboard players get @s scrfx.zinternals.player_id
data modify storage scrfx:zinternals temp.to_play.screen_effect_id set from storage scrfx:in id
function scrfx:zinternals/clear_running_screen_effect with storage scrfx:zinternals temp.to_play
function scrfx:zinternals/set_running_screen_effect with storage scrfx:zinternals temp.to_play
scoreboard players set @s scrfx.zinternals.player.is_running_screen_effect 1
