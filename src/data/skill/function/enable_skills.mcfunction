data remove storage skill:selection selector
execute store result storage skill:selection selector.uid int 1 run scoreboard players get @s uid.player
function skill:get_skills with storage skill:selection selector
function ./announcement/set_team with storage skill:selection selector
function ./announcement/set_team:
    $execute store result storage skill:selection RoundSelections[{"uid":$(uid)}].team_id int 1 run scoreboard players get @s game.player.team_id
execute unless data storage skill:selection Recursive[0] run return fail # Return function if no selection is found

execute at @s run function skill:add_tags with storage skill:selection Recursive[0]

execute function ./random/filter_tags:
    # Manage random players
    data remove storage skill:selection Recursive
    execute if entity @s[tag=skill.runner.random] run data modify storage skill:selection Recursive append from storage skill:registry RunnerSkills[]
    execute if entity @s[tag=skill.killer.random] run data modify storage skill:selection Recursive append from storage skill:registry KillerSkills[]
    execute if entity @s[tag=skill.weapon.random] run data modify storage skill:selection Recursive append from storage skill:registry WeaponRegistry[]
    data remove storage skill:selection Recursive[{"is_random": 1}]
    function skill:remove_tags with storage skill:selection Recursive[0]

# Add random skills to random players
execute if score @s[tag=skill.runner.random] game.player.team_id matches 1 run function skill:selection/random/runner_skill
execute if score @s[tag=skill.killer.random] game.player.team_id matches 2 run function skill:selection/random/killer_skill
execute if score @s[tag=skill.weapon.random] game.player.team_id matches 2 run function skill:selection/random/weapon