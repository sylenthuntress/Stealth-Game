from bolt_expressions import Scoreboard
from util:score_math import percentage

# Create and set the necessary variables
scoreboard objectives add var.player_count dummy
scoreboard objectives add var.killer_count dummy
playerCount = Scoreboard("var.player_count")
killerCount = Scoreboard("var.killer_count")
killerRatio = Scoreboard("config.killer_ratio")

execute store result score $variable var.player_count run function util:get/players
playerCount["$variable"] = percentage(playerCount["$variable"], killerRatio["$config"])

# Select random player as killer, then loop until complete
execute as @r[tag=playing,tag=!killer_blacklist] run scoreboard players set @s game.player.team_id 2
tag @a[scores={game.player.team_id=2}] add killer_blacklist

execute store result score $variable var.killer_count run execute if entity @a[scores={game.player.team_id=2}]
execute if score $variable var.killer_count < $variable var.player_count run function game:round/random_teams

# Remove variables when done
scoreboard objectives remove var.player_count
scoreboard objectives remove var.killer_count