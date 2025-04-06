$execute unless data storage scrfx:running_screen_effects running."$(player_id)".$(frame).callback run return run function scrfx:zinternals/errors/callback_not_found with storage scrfx:zinternals temp.to_run_callback
$data modify storage scrfx:zinternals temp.to_run_callback.command set from storage scrfx:running_screen_effects running."$(player_id)".$(frame).callback
function scrfx:zinternals/run_callback/run_command with storage scrfx:zinternals temp.to_run_callback
