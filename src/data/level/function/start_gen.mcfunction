import util:coordinates as coords

# Reset map
fill coords.play_area.x coords.play_area.y coords.play_area.z (coords.play_area.x + 69) (coords.play_area.y + 30) (coords.play_area.z + 1000) air
kill @e[type=text_display,tag=band_display]
kill @e[tag=segment_entity]
kill @e[tag=gameplay.killer.backdoor.final_warp]

# Enable command blocks
gamerule command_blocks_work true

# Create level pool based on registry
execute function level:segment/make_pool:
    data remove storage level:pool SegmentEntries
    data remove storage level:registry Recursive
    data modify storage level:registry Recursive set from storage level:registry SegmentRegistry
    execute run function level:segment/make_pool_r:
        data modify storage level:pool SegmentEntries prepend value {"type": "minecraft:item", "name": "minecraft:stick", "weight": 0, "modifier": {"type": "minecraft:set_name", "name": ""}}
        data modify storage level:pool SegmentEntries[0].weight set from storage level:registry Recursive[0].weight
        data modify storage level:pool SegmentEntries[0].biome set from storage level:registry Recursive[0].biome
        data modify storage level:pool SegmentEntries[0].modifier.name set from storage level:registry Recursive[0].id

        data remove storage level:registry Recursive[0]
        execute if data storage level:registry Recursive[0] run function level:segment/make_pool_r
# Create band pool based on registry
execute function level:band/make_pool:
    data remove storage level:pool BandEntries
    data remove storage level:registry Recursive
    data modify storage level:registry Recursive set from storage level:registry BandRegistry
    execute run function level:band/make_pool_r:
        data modify storage level:pool BandEntries prepend value {"type": "minecraft:item", "name": "minecraft:stick", "weight": 0, "modifier": {"type": "minecraft:set_name", "name": ""}}
        data modify storage level:pool BandEntries[0].weight set from storage level:registry Recursive[0].weight
        data modify storage level:pool BandEntries[0].modifier.name set from storage level:registry Recursive[0].id

        data remove storage level:registry Recursive[0]
        execute if data storage level:registry Recursive[0] run function level:band/make_pool_r

# Store the amount of segments to generate
scoreboard players set #segments segments.elapsed 0
scoreboard players set #segments segments.remaining 0
scoreboard players set #segments segments.remaining_small 0
scoreboard players set #segments segments.remaining_med 0
scoreboard players set #segments segments.remaining_large 0

scoreboard players operation #segments segments.remaining += #config config.segments_small
scoreboard players operation #segments segments.remaining += #config config.segments_med
scoreboard players operation #segments segments.remaining += #config config.segments_large

scoreboard players operation #segments segments.remaining_small += #config config.segments_small
scoreboard players operation #segments segments.remaining_med += #config config.segments_med
scoreboard players operation #segments segments.remaining_large += #config config.segments_large

# Clear previous segments
execute if score #prev.segments segments.elapsed matches 1.. positioned coords.play_area.x (coords.play_area.y-17) coords.play_area.z function level:segment/clear:
    forceload add ~-100 ~ ~200 ~70
    fill ~-100 41 ~ ~200 ~60 ~70 air
    fillbiome ~-100 41 ~ ~200 ~60 ~70 minecraft:the_void
    scoreboard players remove #prev.segments segments.elapsed 1
    execute if score #prev.segments segments.elapsed matches 1.. positioned ~ ~ ~30 run function level:segment/clear
    forceload remove ~-100 ~ ~200 ~70

# Start generating segments
execute positioned coords.play_area.x (coords.play_area.y-19) coords.play_area.z function level:segment/create:
    forceload add ~ ~ ~69 ~35
    execute if score #segments segments.elapsed matches 1.. run function level:band/create:
        summon minecraft:text_display ~34 ~30 ~-3 {Tags: ["band_display"], brightness:{sky:15,block:15}, alignment: "center", background: 0, billboard: "vertical", default_background: 0b, line_width: 200, view_range: 2f, see_through: 0b, shadow: 1b, text:{"color":"red","score":{"name":"#segments","objective":"segments.elapsed"}}, text_opacity: -1b, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [50.0f, 50.0f, 50.0f], translation: [0.0f, 0.0f, 0.0f]}}
        scoreboard players operation @n[type=text_display,tag=band_display] segments.elapsed = #segments segments.elapsed
        function level:band/get_random with storage level:pool
        execute positioned ~ ~ ~-5 run function level:band/place with storage level:pool
        execute positioned ~ 41 ~-1 run fill ~ ~ ~ ~68 41 ~-4 minecraft:diamond_block
    function level:segment/get_random with storage level:pool
    function level:segment/place with storage level:pool

    # TODO: add better wall generation
    execute function ./place_wall:
        execute store result score #random walls.random run random value 1..5
        for n in range(1, 6):
            execute if score #random walls.random matches n expand:
                place template f"level:wall/night_{n}" ~-7 41 ~
                place template f"level:wall/night_{n}" ~69 41 ~
                execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 1.. run place template f"level:wall/night_{n}" ~2 41 ~
                execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 1.. run place template f"level:wall/night_{n}" ~59 41 ~
                execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 0 run place template f"level:wall/night_{n}" ~15 41 ~
                execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 0 run place template f"level:wall/night_{n}" ~49 41 ~

        wallMaterial = "black_concrete"
        borderMaterial = "gray_glazed_terracotta"
        fill ~ 41 ~-1 ~-9 ~46 ~-5 borderMaterial
        fill ~68 41 ~-1 ~77 ~46 ~-5 borderMaterial
        fill ~ ~47 ~ ~70 ~47 ~35 barrier
        execute if score #segments segments.elapsed matches 1.. expand:
            # Shrink map segment to medium
            execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 1.. run fill ~-1 41 ~-1 ~9 ~46 ~-5 borderMaterial
            execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 1.. run fill ~69 41 ~-1 ~58 ~46 ~-5 borderMaterial

            # Shrink map segment to small
            execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 0 run fill ~-1 41 ~-1 ~22 ~46 ~-5 borderMaterial
            execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 0 run fill ~69 41 ~-1 ~48 ~46 ~-5 borderMaterial

    # Place pipes
    # execute if score #segments segments.elapsed matches 3.. run place template level:pipes ~45 ~32 ~-6
    # execute if score #segments segments.elapsed matches 3.. run place template level:pipes ~23 ~32 ~ 180

    # Finish the chain and start the next segment if queued
    execute if score #segments segments.remaining_large matches 1.. run scoreboard players remove #segments segments.remaining_large 1
    execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 1.. run scoreboard players remove #segments segments.remaining_med 1
    execute if score #segments segments.remaining_large matches 0 if score #segments segments.remaining_med matches 0 run scoreboard players remove #segments segments.remaining_small 1
    scoreboard players remove #segments segments.remaining 1
    scoreboard players add #segments segments.elapsed 1
    execute if score #segments segments.remaining matches 0 expand:
        forceload add ~69 ~ ~49 ~80
        place template level:finish_line ~22 ~ ~25
        fill ~ 41 ~29 ~49 41 ~25 minecraft:netherite_block
        execute positioned ~ ~ ~30 expand: 
            function ./place_wall
            execute positioned ~ ~ ~25 run place template f"level:wall/night_{n}" ~15 41 ~
            execute positioned ~ ~ ~25 run place template f"level:wall/night_{n}" ~49 41 ~
        summon minecraft:text_display ~34 ~30 ~27 {Tags: ["band_display"], brightness:{sky:15,block:15}, alignment: "center", background: 0, billboard: "vertical", default_background: 0b, line_width: 200, view_range: 2f, see_through: 0b, shadow: 1b, text:{"color":"red","bold":true,"translate": "game.finish"}, text_opacity: -1b, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [50.0f, 50.0f, 50.0f], translation: [0.0f, 0.0f, 0.0f]}}
        summon minecraft:marker ~34 ~17 ~50 {Tags: ["gameplay.killer.backdoor.final_warp"]}
        execute positioned ~34 ~30 ~25 run scoreboard players operation @n[type=text_display,tag=band_display] segments.elapsed = #segments segments.elapsed
    unless score #segments segments.remaining matches ..0 positioned ~ ~ ~30 run function level:segment/create

scoreboard players operation #prev.segments segments.elapsed = #segments segments.elapsed
execute if score #gamestate gamestate.generating matches 1 run function game:finish_generation

# Disable command blocks
schedule function level:disable_command_blocks 10t
function level:disable_command_blocks:
    gamerule command_blocks_work false