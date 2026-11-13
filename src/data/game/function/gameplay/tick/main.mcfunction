# Tick subtasks
function game:gameplay/tick/timer
execute as @a[scores={game.player.team_id=1},gamemode=adventure] at @s run function game:gameplay/tick/runners
execute as @a[scores={game.player.team_id=2},gamemode=adventure] at @s run function game:gameplay/tick/killers

# Manage all players
execute as @a[scores={data.jump=1..}] run function game:gameplay/validate_jump
execute as @a[scores={time.player.stun_timer=-2147483648..}] run function ./../movement_penalty/stun

## Manage camera effectiveness
execute as @a[predicate=!util:is_moving] unless score @s time.player.standing_still matches 10.. run scoreboard players add @s time.player.standing_still 1
execute as @a[predicate=util:is_moving] unless score @s time.player.standing_still matches ..-10 run scoreboard players remove @s time.player.standing_still 1

execute as @a[scores={time.player.standing_still=0..}] run attribute @s minecraft:camera_distance modifier add game:gameplay/standing 2 add_multiplied_base
execute as @a[scores={time.player.standing_still=..-1}] run attribute @s minecraft:camera_distance modifier remove game:gameplay/standing

# Apply due points
execute as @a[scores={game.player.due_points=1..}] at @s run function game:points/add_points
execute as @a[scores={time.player.assist_timer=1..}] run scoreboard players remove @s time.player.assist_timer 1

# Tick corpses
scoreboard players add @e[type=mannequin,tag=game.runner_corpse] time.player.corpse_age 1