function scrfx:zinternals/show_title
execute if score @s scrfx.zinternals.player.current_frame = @s scrfx.zinternals.player.middle_frame run function scrfx:zinternals/tick/tick_screen_effect/nested_execute_1
scoreboard players operation @s scrfx.zinternals.player.ticks_left = @s scrfx.zinternals.player.tps
scoreboard players add @s scrfx.zinternals.player.current_frame 1
