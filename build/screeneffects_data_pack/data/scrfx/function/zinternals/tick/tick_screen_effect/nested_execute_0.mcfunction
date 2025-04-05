function scrfx:zinternals/show_title
scoreboard players operation @s scrfx.zinternals.player.ticks_left = @s scrfx.zinternals.player.tps
scoreboard players add @s scrfx.zinternals.player.current_frame 1
