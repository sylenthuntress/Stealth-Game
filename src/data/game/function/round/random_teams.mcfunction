from bolt_expressions import Scoreboard
from util:score_math import percentage

# Create and set the necessary variables
scoreboard objectives add var.player_count dummy
scoreboard objectives add var.seeker_count dummy
playerCount = Scoreboard("var.player_count")
seekerCount = Scoreboard("var.seeker_count")
seekerRatio = Scoreboard("config.seeker_ratio")

execute store result score $variable var.player_count run function util:get/players
playerCount["$variable"] = percentage(playerCount["$variable"], seekerRatio["$config"])

# Select random player as seeker, then loop until complete
execute as @r[tag=playing,tag=!seeker_blacklist] unless score @s game.player.team_id matches 1 run scoreboard players set @s game.player.team_id 1
tag @a[scores={game.player.team_id=1}] add seeker_blacklist

execute store result score $variable var.seeker_count run execute if entity @a[scores={game.player.team_id=1}]
execute if score $variable var.seeker_count < $variable var.player_count run function game:round/random_teams

# Remove variables when done
scoreboard objectives remove var.player_count
scoreboard objectives remove var.seeker_count