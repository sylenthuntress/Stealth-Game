import util:coordinates as coords

# Reset map
fill coords.play_area.x coords.play_area.y coords.play_area.z (coords.play_area.x + 69) (coords.play_area.y + 30) (coords.play_area.z + 160) air

# Create level pool based on registry
data merge storage level:pool {Entries:[]}
data remove storage level:registry Recursive
data modify storage level:registry Recursive set from storage level:registry Registry
execute run function level:start_gen_r:
    data modify storage level:pool Entries prepend value {"type": "minecraft:item", "name": "minecraft:stick", "weight": 0, "modifier": {"type": "minecraft:set_name", "name": ""}}
    data modify storage level:pool Entries[0].weight set from storage level:registry Recursive[0].weight
    data modify storage level:pool Entries[0].modifier.name set from storage level:registry Recursive[0].id

    data remove storage level:registry Recursive[0]
    execute if data storage level:registry Recursive[0] run function level:start_gen_r

# Store the amount of segments to generate
scoreboard players set $segments segments.remaining 0
scoreboard players set $segments segments.remaining_small 0
scoreboard players set $segments segments.remaining_med 0
scoreboard players set $segments segments.remaining_large 0

scoreboard players operation $segments segments.remaining += $config config.segments_small
scoreboard players operation $segments segments.remaining += $config config.segments_med
scoreboard players operation $segments segments.remaining += $config config.segments_large

scoreboard players operation $segments segments.remaining_small += $config config.segments_small
scoreboard players operation $segments segments.remaining_med += $config config.segments_med
scoreboard players operation $segments segments.remaining_large += $config config.segments_large

# Start generating segments
execute positioned coords.play_area.x (coords.play_area.y-17) coords.play_area.z function level:make_segment:
    forceload add ~ ~
    function level:get_random
    function level:place_segment with storage level:pool

    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 1.. run fill ~ ~ ~ ~9 ~31 ~25 air
    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 1.. run fill ~69 ~ ~ ~59 ~31 ~25 air

    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 0 run fill ~ ~ ~ ~19 ~31 ~25 air
    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 0 run fill ~69 ~ ~ ~49 ~31 ~25 air

    execute if score $segments segments.remaining_large matches 1.. run scoreboard players remove $segments segments.remaining_large 1
    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 1.. run scoreboard players remove $segments segments.remaining_med 1
    execute if score $segments segments.remaining_large matches 0 if score $segments segments.remaining_med matches 0 run scoreboard players remove $segments segments.remaining_small 1
    scoreboard players remove $segments segments.remaining 1
    execute unless score $segments segments.remaining matches ..0 positioned ~ ~ ~30 run function level:make_segment
    forceload remove ~ ~