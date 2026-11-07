from ./main import maxCharge

append function_tag event:on_jump {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.jumper] run return fail
execute unless score @s skill.runner.jumper.charge matches 1.. run return fail

playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 2
for n in range(1, maxCharge+1):
    execute if score @s skill.runner.jumper.charge matches n playsound minecraft:entity.slime.jump master @a[distance=(0, n*3)] ~ ~ ~ (0 + n/(maxCharge)*3) (1.5 + n/(maxCharge*2))
    particle minecraft:item_slime ~ ~ ~ 0.1 (-0.5 + n/maxCharge) 0.1 1 10 normal
attribute @s minecraft:jump_strength modifier remove game:runner/jumper/charging
scoreboard players reset @s skill.runner.jumper.charge
scoreboard players reset @s skill.runner.jumper.charge_cooldown