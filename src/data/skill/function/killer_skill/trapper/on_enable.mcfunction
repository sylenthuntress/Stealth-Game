append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.trapper] run return fail

for i in range(3):
    function ./give_item
    scoreboard players add @s skill.killer.trapper.count 1