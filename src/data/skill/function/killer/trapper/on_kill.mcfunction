append function_tag skill:event/on_kill {
    "values": [(./on_kill)]
}

execute unless entity @s[tag=skill.killer.trapper] run return fail

for i in range(3):
    execute if score @s skill.killer.trapper.count matches 3 expand:
        function ./random_trap
    execute unless score @s skill.killer.trapper.count matches 3 expand:
        function ./give_item
        scoreboard players add @s skill.killer.trapper.count 1