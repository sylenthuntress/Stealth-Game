append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.breeze] run return fail

scoreboard players set @s skill.killer.breeze.cooldown 300 
for i in range(1, 3):
    function ./give_item