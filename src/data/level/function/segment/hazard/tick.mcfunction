from util:constants import axes

execute as @e[type=marker,tag=dripleaf_launcher] at @s positioned ~ ~-1 ~ run function level:segment/hazard/dripleaf/tick:
    scoreboard players remove @s[scores={game.hazard.dripleaf_launcher.timer=1..}] game.hazard.dripleaf_launcher.timer 1
    execute at @p if block ~ ~-0.1 ~ big_dripleaf unless block ~ ~-0.1 ~ big_dripleaf[tilt=full] run function level:segment/hazard/dripleaf/launch:
        for axis in axes:
            execute positioned ~ ~-0.1 ~ if block ~ ~ ~ big_dripleaf[facing=axis] unless block ~ ~ ~ big_dripleaf[tilt=full] run setblock ~ ~ ~ big_dripleaf[tilt=full,facing=axis]
        scoreboard players set @e[type=marker,tag=dripleaf_launcher,limit=1,sort=nearest] game.hazard.dripleaf_launcher.timer 100
        summon breeze_wind_charge ~ ~-0.1 ~ {acceleration_power:10d,Motion:[0.0,-10.0,0.0]}
        summon breeze_wind_charge ~ ~-0.1 ~ {acceleration_power:10d,Motion:[0.0,-10.0,0.0]}
        data modify storage var:coords y set from entity @s Pos[1]
        function util:reset_vertical_momentum with storage temp:coords
        data remove storage var:coords y
    for axis in axes:
        execute if score @s game.hazard.dripleaf_launcher.timer matches 0 if block ~ ~ ~ big_dripleaf[facing=axis] run setblock ~ ~ ~ big_dripleaf[tilt=none,facing=axis]