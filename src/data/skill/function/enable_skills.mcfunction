data remove storage skill:selection selector
execute store result storage skill:selection selector.uid int 1 run scoreboard players get @s uid.player
function skill:get_skills with storage skill:selection selector

function skill:add_tags with storage skill:selection Recursive[0]

execute function skill:filter_tags:
    # Remove tags that don't fit your team
    data remove storage skill:selection Recursive
    execute if score @s game.player.team_id matches 2 run data modify storage skill:selection Recursive append from storage skill:registry RunnerSkills[]
    execute if score @s game.player.team_id matches 1 run data modify storage skill:selection Recursive append from storage skill:registry KillerSkills[]
    execute if score @s game.player.team_id matches 1 run data modify storage skill:selection Recursive append from storage skill:registry WeaponRegistry[]

    function skill:remove_tags with storage skill:selection Recursive[0]

    # Manage random players
    data remove storage skill:selection Recursive
    execute if entity @s[tag=skill.runner.random] run data modify storage skill:selection Recursive append from storage skill:registry RunnerSkills[]
    execute if entity @s[tag=skill.killer.random] run data modify storage skill:selection Recursive append from storage skill:registry KillerSkills[]
    execute if entity @s[tag=skill.weapon.random] run data modify storage skill:selection Recursive append from storage skill:registry WeaponRegistry[]

    data remove storage skill:selection Recursive[{"id": "skill.runner.random"}]
    data remove storage skill:selection Recursive[{"id": "skill.killer.random"}]
    data remove storage skill:selection Recursive[{"id": "skill.weapon.random"}]

    function skill:remove_tags with storage skill:selection Recursive[0]

# Add random skills to random players
execute if score @s[tag=skill.runner.random] game.player.team_id matches 1 run function skill:selection/random/runner_skill
execute if score @s[tag=skill.killer.random] game.player.team_id matches 2 run function skill:selection/random/killer_skill
execute if score @s[tag=skill.weapon.random] game.player.team_id matches 2 run function skill:selection/random/weapon