# Apply healing based on queued heal amount
scoreboard players operation @s game.player.injury -= @s game.player.heal_amount
scoreboard players operation @s game.player.heal_amount /= $2 math.const.2
scoreboard players operation @s game.player.damage -= @s game.player.heal_amount
scoreboard players reset @s game.player.heal_amount

scoreboard players set @s[scores={game.player.damage=..0}] game.player.damage 0
scoreboard players set @s[scores={game.player.injury=..0}] game.player.injury 0

# Apply movement speed penalty
function game:gameplay/update_health