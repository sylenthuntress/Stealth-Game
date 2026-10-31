append function_tag skill:event/band_claimed {
    "values": [(./band_claimed)]
}

execute unless entity @s[tag=skill.killer.trapper] run return fail

execute if score @s skill.killer.trapper.count matches 3 expand:
    function ./random_trap
execute unless score @s skill.killer.trapper.count matches 3 expand:
    function ./give_item
    scoreboard players add @s skill.killer.trapper.count 1