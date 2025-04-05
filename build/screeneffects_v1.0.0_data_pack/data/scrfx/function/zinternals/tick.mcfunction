execute as @a[tag=!scrfx.player.init] run function scrfx:zinternals/tick/set_player_id
execute as @a if score @s scrfx.zinternals.player.is_running_screen_effect matches 1 run function scrfx:zinternals/tick/tick_screen_effect
