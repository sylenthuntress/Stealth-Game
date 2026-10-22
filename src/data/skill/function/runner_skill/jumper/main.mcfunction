maxCharge = 7
chargeCooldown = 7
chargeMult = 3
green = (0, 255, 0)
def hexify(num):
    return f"{num:02x}"

def hexify_tuple(tup):
    string = ''
    for value in tup:
        string += ''.join(hexify(value))
    return '#' + string

scoreboard players remove @s skill.runner.jumper.charge_cooldown 1
execute at @s if entity @s[tag=hiding,predicate=util:is_sneaking,predicate=!util:is_moving] unless score @s skill.runner.jumper.charge_cooldown matches 1.. unless score @s skill.runner.jumper.charge matches maxCharge run function ./charge:
    scoreboard players add @s skill.runner.jumper.charge 1
    for n in range(1, maxCharge+1):
        new_green = (green[0], int(green[1] * (1 - n/maxCharge/2)), green[2])
        execute if score @s skill.runner.jumper.charge matches n expand:
            playsound minecraft:block.note_block.bit master @s ~ ~ ~ (1 + n/maxCharge) (0.75 + n/(maxCharge*2))
            playsound minecraft:block.note_block.bit master @a[distance=(0.01, n*3)] ~ ~ ~ (1 + n/maxCharge) (0.75 + n/(maxCharge*2))
            attribute @s minecraft:jump_strength modifier remove game:runner_skill/jumper/hiding
            attribute @s minecraft:jump_strength modifier add game:runner_skill/jumper/hiding (0.15*n) add_value
            scoreboard players set @s skill.runner.jumper.charge_cooldown (chargeCooldown+int(n*chargeMult))
            title @s[scores={skill.runner.jumper.charge=1..}] actionbar {
                "color": "gold",
                "bold": true,
                "italic": false,
                "translate": "skill.cooldown",
                "with": [
                    {
                        "score": {
                            "name": "@s",
                            "objective": "skill.runner.jumper.charge"
                        },
                        "bold": true,
                        "color": hexify_tuple(new_green)
                    }
                ]
            }

    execute if score @s skill.runner.jumper.charge matches maxCharge run scoreboard players set @s skill.runner.jumper.charge_cooldown int(chargeCooldown/chargeMult)

execute at @s if entity @s[tag=hiding,predicate=util:is_sneaking,predicate=!util:is_moving] unless score @s skill.runner.jumper.charge_cooldown matches 1.. if score @s skill.runner.jumper.charge matches maxCharge run function ./max_charge:
    playsound minecraft:block.note_block.bit master @a[distance=(0, maxCharge*3)] ~ ~ ~ 2 1.25
    scoreboard players set @s skill.runner.jumper.charge_cooldown int(chargeCooldown/chargeMult)
    title @s[scores={skill.runner.jumper.charge=1..}] actionbar {
        "color": "gold",
        "bold": true,
        "italic": false,
        "translate": "skill.cooldown",
        "with": [
            {
                "score": {
                    "name": "@s",
                    "objective": "skill.runner.jumper.charge"
                },
                "bold": true,
                "color": hexify_tuple(new_green)
            }
        ]
    }

execute if entity @s[tag=hiding,predicate=util:is_moving,scores={skill.runner.jumper.charge_cooldown=1..}] unless score @s skill.runner.jumper.charge matches maxCharge run function ./moving:
    for n in range(1, maxCharge+1):
        execute if score @s skill.runner.jumper.charge matches n scoreboard players set @s skill.runner.jumper.charge_cooldown (chargeCooldown+int(n*chargeMult))
execute if entity @s[tag=hiding,predicate=!util:is_sneaking,scores={skill.runner.jumper.charge_cooldown=1..}] run function ./moving

execute at @s if score @s data..jump matches 1 if score @s skill.runner.jumper.charge matches 1.. run function ./jump:
    function game:gameplay/runner/stop_hiding
    playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 2
    for n in range(1, maxCharge+1):
        execute if score @s skill.runner.jumper.charge matches n playsound minecraft:entity.slime.jump master @a[distance=(0, n*3)] ~ ~ ~ (0 + n/(maxCharge)*3) (1.5 + n/(maxCharge*2))
        particle minecraft:item_slime ~ ~ ~ 0.1 (-0.5 + n/maxCharge) 0.1 1 10 normal
    attribute @s minecraft:jump_strength modifier remove game:runner_skill/jumper/hiding
    scoreboard players reset @s skill.runner.jumper.charge
    scoreboard players reset @s skill.runner.jumper.charge_cooldown

execute if entity @s[tag=!hiding] run function ./not_hiding:
    attribute @s minecraft:jump_strength modifier remove game:runner_skill/jumper/hiding
    scoreboard players reset @s skill.runner.jumper.charge
    scoreboard players reset @s skill.runner.jumper.charge_cooldown
    title @s[scores={skill.runner.jumper.charge=1..}] actionbar {
        "color": "gold",
        "bold": true,
        "italic": false,
        "translate": "skill.cooldown",
        "with": [
            {
                "score": {
                    "name": "@s",
                    "objective": "skill.runner.jumper.charge"
                },
                "bold": true,
                "color": hexify_tuple(green)
            }
        ]
    }