execute if score @s scrfx.zinternals.player.current_frame = @s scrfx.zinternals.player.frame_count run return run function scrfx:zinternals/tick/tick_screen_effect/nested_return_0
execute if score @s scrfx.zinternals.player.ticks_left matches 0 run function scrfx:zinternals/tick/tick_screen_effect/nested_execute_0
execute if score @s scrfx.zinternals.player.ticks_left matches 1.. run scoreboard players remove @s scrfx.zinternals.player.ticks_left 1
