append function_tag skill:event/cross_band {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.warper] run return fail

execute unless score @s skill.runner.warper.count matches 2.. run function ./give_item