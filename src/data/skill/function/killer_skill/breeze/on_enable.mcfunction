append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.breeze] run return fail

scoreboard players set @s skill.killer.breeze.cooldown 300 
for i in range(1, 3):
    function ./give_item