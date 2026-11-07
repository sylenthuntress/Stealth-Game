from ./main import maxCharge, chargeCooldown, chargeMult, green
advancement ~/: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:using_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.runner.jumper.ability: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (~/)
    }
}

advancement revoke @s only ~/
execute unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:1b}}} run return fail

scoreboard players remove @s skill.runner.jumper.charge_cooldown 1
execute at @s unless score @s skill.runner.jumper.charge_cooldown matches 1.. unless score @s skill.runner.jumper.charge matches maxCharge run function ./charge:
    scoreboard players add @s skill.runner.jumper.charge 1
    for n in range(1, maxCharge+1):
        new_green = (green[0], int(green[1] * (1 - n/maxCharge/2)), green[2])
        execute if score @s skill.runner.jumper.charge matches n expand:
            playsound minecraft:block.note_block.bit master @s ~ ~ ~ (1 + n/maxCharge) (0.75 + n/(maxCharge*2))
            playsound minecraft:block.note_block.bit master @a[distance=(0.01, n*3)] ~ ~ ~ (1 + n/maxCharge) (0.75 + n/(maxCharge*2))
            attribute @s minecraft:jump_strength modifier remove game:runner/jumper/charging
            attribute @s minecraft:jump_strength modifier add game:runner/jumper/charging (0.15*n) add_value
            scoreboard players set @s skill.runner.jumper.charge_cooldown (chargeCooldown+int(n*chargeMult))

    execute if score @s skill.runner.jumper.charge matches maxCharge run scoreboard players set @s skill.runner.jumper.charge_cooldown int(chargeCooldown/chargeMult)

execute at @s unless score @s skill.runner.jumper.charge_cooldown matches 1.. if score @s skill.runner.jumper.charge matches maxCharge run function ./max_charge:
    playsound minecraft:block.note_block.bit master @a[distance=(0, maxCharge*3)] ~ ~ ~ 2 1.25
    scoreboard players set @s skill.runner.jumper.charge_cooldown int(chargeCooldown/chargeMult)