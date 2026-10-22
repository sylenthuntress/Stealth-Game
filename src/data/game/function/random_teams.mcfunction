scoreboard objectives add var.candidates dummy
scoreboard objectives add var.queue dummy
scoreboard objectives add var.players dummy

# Sort players randomly, and select based on percentage
execute as @a[tag=game.playing,sort=random] unless score @s game.player.killer_queue matches 1.. store result score @s var.queue run scoreboard players add #var var.candidates 100
execute as @a[tag=game.playing] if score @s game.player.killer_queue matches 1.. run scoreboard players add #var var.candidates 100

scoreboard players operation #var var.candidates /= #100 math.const
scoreboard players operation #var var.candidates *= #config config.killer_ratio
scoreboard players add #var var.candidates 50
execute if score #var var.candidates matches ..100 run scoreboard players set #var var.candidates 100

# Check for the odd player out
execute store result score #players var.players if entity @a[tag=game.playing,tag=!killer_blacklist] 
execute as @a if score @s game.player.killer_queue = #queue game.player.killer_queue run scoreboard players add #team_size var.players 1
execute if score #team_size var.players matches 1.. if score #players var.players < #team_size var.players as @a[tag=game.playing,tag=!killer_blacklist] run function game:uneven_players:
    scoreboard players set @s game.player.killer_queue -1
    tag @s add killer_blacklist
execute if entity @a[scores={game.player.killer_queue=-1}] run tellraw @a {"translate":"game.player.uneven_players","color":"red","italic":true,"with":[{"selector":"@a[scores={game.player.killer_queue=-1}]","color":"gray","bold":false}]}

# Place targets into queue
scoreboard players add #queue game.player.killer_queue 1
execute as @a[tag=game.playing,tag=!killer_blacklist] if score @s var.queue <= #var var.candidates expand:
    scoreboard players operation @s game.player.killer_queue = #queue game.player.killer_queue
    tellraw @s {"translate":"game.player.killer_queue","bold":true,"color":"gray","with":[[{"text":"#","bold":false,"color":"red"},{"score":{"name":"@s","objective":"game.player.killer_queue"}}]]}
    if score #team_size var.players matches 2.. expand:
        tag @s add killer_teammate
        tellraw @s {"translate":"game.player.killer_queue.team","bold":true,"color":"gray","with":[[{"selector":"@a[tag=killer_teammate]","bold":false,"italic":true}]]}
        tag @s remove killer_teammate
    tag @s add killer_blacklist

scoreboard objectives remove var.candidates
scoreboard objectives remove var.queue
scoreboard objectives remove var.players

# Loop
execute if entity @a[tag=game.playing,tag=!killer_blacklist] run function game:random_teams
tag @a remove killer_blacklist
scoreboard players reset #queue game.player.killer_queue