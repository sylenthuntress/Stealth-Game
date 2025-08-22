# Set variables
scoreboard players set $gamestate gamestate.game_active 0
scoreboard players set $gamestate gamestate.round_active 0
bossbar set game:time/round_timer players

# Reset player tags
tag @a remove playing
tag @a remove seeker_blacklist

# Broadcast ending message
tellraw @a {translate:"game.end"}

# Sort points
execute run function game:rankings/broadcast_all:
    scoreboard objectives add var.placement dummy
    execute unless score $variable var.placement matches -2147483648..2147483647 function game:rankings/calculate_winner:
        execute store result score $variable var.placement run function util:get/players
        tag @a remove winner
        
        execute as @a run function game:rankings/check_winner:
            scoreboard players operation @s var.placement = $variable var.placement

            tag @s add placing
            execute as @a if score @s game.player.points > @a[limit=1,tag=placing] game.player.points run scoreboard players remove @a[limit=1,tag=placing] var.placement 1
            tag @s remove placing

            execute if score @s var.placement = $variable var.placement run tag @s add winner
            scoreboard players operation @s var.placement -= $variable var.placement
    execute as @a[scores={var.placement=0}] run function game:rankings/broadcast_self:
        say TODO: add text here #TODO
        scoreboard players reset @s
    scoreboard players add @a var.placement 1
    execute if entity @a[scores={var.placement=0}] run function game:rankings/broadcast_all

    scoreboard objectives remove var.placement # Remove unneeded variable
scoreboard players reset @a game.player.points # Reset points for next game
scoreboard objectives setdisplay sidebar # Clear points from sidebar