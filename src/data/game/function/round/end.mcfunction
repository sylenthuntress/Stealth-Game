# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $time time.round_cooldown 100

# Put every player in spectator
gamemode spectator @a[tag=playing]