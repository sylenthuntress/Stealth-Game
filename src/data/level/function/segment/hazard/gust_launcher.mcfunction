from util:constants import axes

function ~/tick:
    append function_tag level:segment/tick {
        "values": [(~/)]
    }

    execute unless entity @s[tag=segment_entity.hazard.gust_launcher] run return fail
    execute unless score @s hazard.gust_launcher.timer matches 1.. at @p[distance=..1] run function ./launch
    execute unless score @s hazard.gust_launcher.timer matches 1.. unless entity @e[type=breeze_wind_charge,tag=segment_entity.hazard.gust_launcher.charge,distance=..1] run function ./launch
    function ./launch:
        kill @n[type=breeze_wind_charge,tag=segment_entity.hazard.gust_launcher.charge,distance=..1]

        for axis in axes:
            execute positioned ~ ~-0.1 ~ if block ~ ~ ~ big_dripleaf[facing=axis] unless block ~ ~ ~ big_dripleaf[tilt=full] run setblock ~ ~ ~ big_dripleaf[tilt=full,facing=axis]
        scoreboard players set @s hazard.gust_launcher.timer 100

        summon breeze_wind_charge ~ ~-0.1 ~ {acceleration_power:10d,Motion:[0.0,-10.0,0.0]}
        execute if entity @s[tag=segment_entity.hazard.gust_launcher.strong] run summon breeze_wind_charge ~ ~-0.1 ~ {acceleration_power:10d,Motion:[0.0,-10.0,0.0]}

        data modify storage var:coords y set from entity @p[distance=..1] Pos[1]
        execute as @p[distance=..1] run function util:reset_vertical_momentum with storage var:coords
        data remove storage var:coords y

    execute unless score @s hazard.gust_launcher.timer matches 1.. if block ~ ~ ~ big_dripleaf run particle minecraft:happy_villager ~ ~ ~ 0.2 0 0.2 0.1 1 normal @a
    execute unless score @s hazard.gust_launcher.timer matches 1.. unless block ~ ~ ~ big_dripleaf run particle minecraft:small_gust ~ ~ ~ 0.2 0 0.2 0.01 1 normal @a

    scoreboard players remove @s[scores={hazard.gust_launcher.timer=1..}] hazard.gust_launcher.timer 1
    for axis in axes:
            execute if score @s hazard.gust_launcher.timer matches 1.. if block ~ ~ ~ big_dripleaf[facing=axis] run setblock ~ ~ ~ big_dripleaf[tilt=full,facing=axis]
    execute if score @s hazard.gust_launcher.timer matches 0 run function ./end_cooldown:
        scoreboard players reset @s hazard.gust_launcher.timer
        summon breeze_wind_charge ~ ~.25 ~ {Tags:["segment_entity","segment_entity.hazard.gust_launcher.charge"]}

        for axis in axes:
            execute if block ~ ~ ~ big_dripleaf[facing=axis] run setblock ~ ~ ~ big_dripleaf[tilt=none,facing=axis]

function ~/place:
    setblock ~ ~ ~ air
    summon marker ~ ~ ~ {Tags:["segment_entity","segment_entity.hazard.gust_launcher","segment_entity.ticking"]}
    summon breeze_wind_charge ~ ~.25 ~ {Tags:["segment_entity","segment_entity.hazard.gust_launcher.charge"]}

function ~/place_strong:
    setblock ~ ~ ~ air
    summon marker ~ ~ ~ {Tags:["segment_entity","segment_entity.hazard.gust_launcher","segment_entity.hazard.gust_launcher.strong","segment_entity.ticking"]}
    summon breeze_wind_charge ~ ~.25 ~ {Tags:["segment_entity","segment_entity.hazard.gust_launcher.charge"]}
