data remove storage skill:data Selection.selector
execute store result storage skill:data Selection.selector.uid int 1 run scoreboard players get @s uid.player
function ./get_skills with storage skill:data Selection.selector
function ./get_skills:
    data modify storage skill:data Selection.Recursive set value []
    $execute if entity @s[scores={game.player.team_id=1}] run data modify storage skill:data Selection.Recursive append from storage skill:data Selection.players[{"uid": $(uid)}].skills[{"type": "skill:runner"}]
    $execute if entity @s[scores={game.player.team_id=2}] run data modify storage skill:data Selection.Recursive append from storage skill:data Selection.players[{"uid": $(uid)}].skills[{"type": "skill:killer"}]
    $execute if entity @s[scores={game.player.team_id=2}] run data modify storage skill:data Selection.Recursive append from storage skill:data Selection.players[{"uid": $(uid)}].skills[{"type": "skill:weapon"}]
function ./announcement/set_team with storage skill:data Selection.selector
function ./announcement/set_team:
    $execute store result storage skill:selection RoundSelections[{"uid":$(uid)}].team_id int 1 run scoreboard players get @s game.player.team_id
execute unless data storage skill:data Selection.Recursive[0] run return fail # Return function if no selection is found

execute at @s run function skill:add_tags with storage skill:data Selection.Recursive[0]

execute function ./../random/filter_tags:
    # Manage random players
    data remove storage skill:data Selection.Recursive
    execute if entity @s[tag=skill.runner.random] run data modify storage skill:data Selection.Recursive append from storage skill:data Registry[{"type": "skill:runner"}]
    execute if entity @s[tag=skill.killer.random] run data modify storage skill:data Selection.Recursive append from storage skill:data Registry[{"type": "skill:killer"}]
    execute if entity @s[tag=skill.weapon.random] run data modify storage skill:data Selection.Recursive append from storage skill:data Registry[{"type": "skill:weapon"}]
    data remove storage skill:data Selection.Recursive[{components:{"skill:random": true}}]
    function skill:remove_tags with storage skill:data Selection.Recursive[0]

# Add random skills to random players
execute if score @s[tag=skill.runner.random] game.player.team_id matches 1 run function ./selection/random/runner_skill
execute if score @s[tag=skill.killer.random] game.player.team_id matches 2 run function ./selection/random/killer_skill
execute if score @s[tag=skill.weapon.random] game.player.team_id matches 2 run function ./selection/random/weapon