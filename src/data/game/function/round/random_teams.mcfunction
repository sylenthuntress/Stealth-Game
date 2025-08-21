# Create and set the necessary variables
scoreboard objectives add var.player_count dummy
scoreboard objectives add var.seeker_count dummy

execute store result score #VARIABLE var.player_count run function util:get/players

scoreboard players operation #OPERAND math.percentage = #VARIABLE var.player_count
scoreboard players operation #OPERATOR math.percentage = #CONFIG config.seeker_ratio
execute store result score #VARIABLE var.player_count run function util:math/percentage

# Select random player as seeker, then loop until complete
execute as @r[tag=playing,tag=!seeker_blacklist] unless score @s game.player.team_id matches 1 run scoreboard players set @s game.player.team_id 1
tag @a[scores={game.player.team_id=1}] add seeker_blacklist

execute store result score #VARIABLE var.seeker_count run execute if entity @a[scores={game.player.team_id=1}]
execute if score #VARIABLE var.seeker_count < #VARIABLE var.player_count run function game:round/random_teams

# Remove variables when done
scoreboard objectives remove var.player_count
scoreboard objectives remove var.seeker_count