# Set variables
scoreboard players add $gamestate gamestate.round_count 1
scoreboard players set $gamestate gamestate.round_active 1
scoreboard players reset $time time.round_cooldown
    # Setup round timer
    execute store result score $time time.round_timer run function util:get/base_timer
    execute store result bossbar game:time/round_timer max run scoreboard players get $time time.round_timer
        
        # Set bossbar visibility
        execute as @a if function util:test/is_playing run tag @s add temp
        bossbar set game:time/round_timer players @a[tag=temp]
        tag @a remove temp

# Distribute teams for everyone
scoreboard players reset @a game.player.team_id

execute if score $config config.team_selection matches 0 run scoreboard players set @a[tag=playing] game.player.team_id 0
execute if score $config config.team_selection matches 0 run function game:round/random_teams

team join sneaker @a[scores={game.player.team_id=0}]
team join seeker @a[scores={game.player.team_id=1}]

    # End game if no sneaker/seeker is found
    execute unless entity @a[team=sneaker] run function game:end
    execute unless entity @a[team=sneaker] run return fail

    execute unless entity @a[team=seeker] run function game:end
    execute unless entity @a[team=seeker] run return fail

# Teleport players to their spawn
teleport @a[scores={game.player.team_id=0}] @e[type=marker,limit=1,tag=sneaker_spawnpoint]
teleport @a[scores={game.player.team_id=1}] @e[type=marker,limit=1,tag=seeker_spawnpoint]