# Create and set the necessary variables
scoreboard objectives add var.damage dummy

execute store result score @s var.damage run attribute @s minecraft:max_health get
scoreboard players operation @s var.damage -= @s data.player.health

# Heal player to avoid incorrect maths
effect give @s instant_health 1 255

# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s var.damage

# Remove variables when done
scoreboard objectives remove var.damage