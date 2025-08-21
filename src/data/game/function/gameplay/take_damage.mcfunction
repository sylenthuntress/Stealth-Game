# Create and set the necessary variables
scoreboard objectives add var.health dummy
scoreboard objectives add var.damage dummy

execute store result score @s var.health run data get entity @s Health
execute store result score @s var.damage run attribute @s minecraft:max_health get
scoreboard players operation @s var.damage -= @s var.health

# Deduct player's health based on taken damage
scoreboard players operation @s game.player.health -= @s var.damage
execute if score @s game.player.health matches ..0 run function game:gameplay/death

# Remove variables when done
scoreboard objectives remove var.damage
scoreboard objectives remove var.health