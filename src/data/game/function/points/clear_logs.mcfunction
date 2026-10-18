function game:points/clear_log_entry with storage points:data PointsLog[0]
data remove storage points:data PointsLog[0]
execute if data storage points:data PointsLog[0] run function game:points/clear_logs
execute unless data storage points:data PointsLog[0] run scoreboard players reset $scoredisplay