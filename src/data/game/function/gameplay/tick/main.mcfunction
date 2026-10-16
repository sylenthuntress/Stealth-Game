# Tick subtasks
function game:gameplay/tick/timer
execute as @a[scores={game.player.team_id=1},gamemode=adventure] at @s run function game:gameplay/tick/runners
execute as @a[scores={game.player.team_id=2},gamemode=adventure] at @s run function game:gameplay/tick/killers

# Manage stun
execute as @a[scores={time.player.stun_timer=1..}] run function game:gameplay/manage_stun

# Apply due points
execute as @a[scores={game.player.due_points=1..}] run function game:add_points
execute as @a[scores={time.player.assist_timer=1..}] run scoreboard players remove @s time.player.assist_timer 1

# Tick corpses
scoreboard players add @e[tag=game.runner_corpse] time.player.corpse_age 1