# Tick subtasks
function game:gameplay/tick/timer
execute as @a[scores={game.player.team_id=1},gamemode=adventure] at @s run function game:gameplay/tick/runners
execute as @a[scores={game.player.team_id=2},gamemode=adventure] at @s run function game:gameplay/tick/killers

# Manage all players
execute as @a[scores={data.jump=1..}] run function game:gameplay/validate_jump
execute as @a[scores={time.player.stun_timer=-2147483648..}] run function ./../movement_penalty/stun

## Manage camera effectiveness
execute as @a[predicate=!util:is_moving] unless score @s time.player.standing_still matches 100.. run scoreboard players add @s time.player.standing_still 1
execute as @a[predicate=util:is_moving] unless score @s time.player.standing_still matches ..-50 run scoreboard players remove @s time.player.standing_still 1

execute as @a run function ./../gameplay/manage_camera:
    data remove storage game:data this
    execute store result storage game:data this.camera_distance double 0.05 run scoreboard players get @s time.player.standing_still
    execute if score @s time.player.standing_still matches ..0 run data modify storage game:data this.camera_distance set value 0 
    function ./../gameplay/set_camera_distance with storage game:data this
    function ./../gameplay/set_camera_distance:
        attribute @s minecraft:camera_distance modifier remove game:gameplay/camera_distance
        $attribute @s minecraft:camera_distance modifier add game:gameplay/camera_distance $(camera_distance) add_multiplied_base

# Apply due points
execute as @a[scores={game.player.due_points=1..}] at @s run function game:points/add_points
execute as @a[scores={time.player.assist_timer=1..}] run scoreboard players remove @s time.player.assist_timer 1

# Tick corpses
scoreboard players add @e[type=mannequin,tag=game.runner_corpse] time.player.corpse_age 1