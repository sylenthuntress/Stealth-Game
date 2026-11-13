advancement ./use_ability: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.runner.warper.ability: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./use_ability)
    }
}

advancement revoke @s only ./use_ability

item fill entity @s ./ability with air

playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 2
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 0
particle minecraft:reverse_portal ~ ~ ~ 0.3 0.5 0.3 0.025 30 normal @a

scoreboard players remove @s skill.runner.warper.count 1
scoreboard players set @s skill.runner.warper.cooldown 600
scoreboard players set @s skill.runner.warper.warp_length 0

tag @s add this.selector
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid = @p[tag=this.selector] uid run tag @s add this.selected

execute as @e[type=marker,tag=this.selected] at @s run function ./find_warp:
    particle minecraft:reverse_portal ~ ~ ~ 0.15 0.25 0.15 0.01 1 normal @a
    scoreboard players operation #var skill.runner.warper.warp_spot > @s skill.runner.warper.warp_spot
    execute if score @s skill.runner.warper.warp_spot = #var skill.runner.warper.warp_spot expand:
        tag @e remove this.warp_spot
        tag @s add this.warp_spot
tp @s @n[tag=this.warp_spot]
tag @s remove this.selector
kill @e[type=marker,tag=this.selected]
scoreboard players reset #var skill.runner.warper.warp_spot

execute at @s run playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1
execute at @s run particle minecraft:portal ~ ~ ~ 0.3 0.5 0.3 0.025 30 normal @a