import util:coordinates as coords

# Remove lobby tag
tag @a[scores={lobby.ready=1}] add game.playing
tag @a[tag=game.playing] add game.viewing
tag @a[tag=game.playing] remove lobby
scoreboard players set @a[tag=game.playing] game.player.in_game 1

# Tellraw
tellraw @a {"text":"\n"}
tellraw @a {"text":"=======================","color":"gold","bold":true}
tellraw @a {"translate":"game.new_match","color":"gray","bold":false,"with": [{"translate":"main.game_name","color":"gold","bold":true}]}

# Start map generation
execute as @a[tag=game.viewing] expand: 
    clear @s
    teleport @s coords.loading.x coords.loading.y coords.loading.z
    effect give @s blindness infinite 255 true
    effect give @s invisibility infinite 255 true
    title @s title ""
    title @s subtitle {"translate":"game.generating","color":"red"}
    at @s run playsound minecraft:block.bell.resonate master @s ~ ~ ~ 1 1.5
scoreboard players set $gamestate gamestate.generating 1
schedule function level:start_gen 10t

# Get random teams
execute if score $config config.team_selection matches 0 run function game:random_teams