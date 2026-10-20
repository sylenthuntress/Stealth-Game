scoreboard players reset @s skill.runner.alchemist.count
item fill entity @s ./ability with air
item fill entity @s ./cooldown with air

tag @s add this.selector
execute as @e[type=snowball,tag=skill.runner_skill.alchemist.blinding_flask] run function ./kill_flask
execute as @e[type=snowball,tag=skill.runner_skill.alchemist.stagger_flask] run function ./kill_flask
tag @s remove this.selector