scoreboard players set @s scrfx.zinternals.player.is_running_screen_effect 0
execute store result storage scrfx:zinternals temp.to_end.player_id int 1 run scoreboard players get @s scrfx.zinternals.player_id
execute if score @s scrfx.zinternals.player.has_end_callback matches 1 run function scrfx:zinternals/tick/tick_screen_effect/nested_execute_0
function scrfx:zinternals/clear_running_screen_effect with storage scrfx:zinternals temp.to_end
