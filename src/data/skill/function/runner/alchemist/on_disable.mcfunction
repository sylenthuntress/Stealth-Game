append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.alchemist] run return fail

item fill entity @s ./ability with air
item fill entity @s ./cooldown with air

tag @s add this.selector
execute as @e[type=snowball,tag=skill.runner.alchemist.blinding_flask] run function ./kill_flask
execute as @e[type=snowball,tag=skill.runner.alchemist.stagger_flask] run function ./kill_flask
tag @s remove this.selector

# Scores
scoreboard players reset @s skill.runner.alchemist.count
scoreboard players reset @s skill.runner.alchemist.cooldown