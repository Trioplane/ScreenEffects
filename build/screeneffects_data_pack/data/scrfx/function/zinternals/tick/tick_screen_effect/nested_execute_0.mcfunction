data modify storage scrfx:zinternals temp.to_run_callback.player_id set from storage scrfx:zinternals temp.to_end.player_id
data modify storage scrfx:zinternals temp.to_run_callback.frame set value "end"
function scrfx:zinternals/run_callback with storage scrfx:zinternals temp.to_run_callback
