import util:coordinates as coords

# Remove lobby tag
tag @a[scores={lobby.ready=1}] add playing
tag @a[tag=playing] remove lobby

# Start map generation
execute as @a[tag=playing] expand: 
    clear @s
    teleport @s coords.loading.x coords.loading.y coords.loading.z
    effect give @s blindness infinite 255 true
    effect give @s invisibility infinite 255 true
    title @s title ""
    title @s subtitle {"translate":"game.generating","color":"red"}
    at @s run playsound minecraft:block.bell.resonate master @s ~ ~ ~ 1 1.5
scoreboard players set $gamestate gamestate.generating 1
schedule function level:start_gen 10t