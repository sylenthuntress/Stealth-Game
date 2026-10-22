advancement ~/ {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:player_interacted_with_entity",
            "conditions": {
                "entity": {
                    "type": "minecraft:entity_properties",
                    "entity": "this",
                    "predicate": {
                        "minecraft:entity_type": "minecraft:interaction",
                        "minecraft:nbt": "{Tags:[\"skill.killer.trapper.trap\"]}"
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
execute unless entity @s[tag=skill.killer.trapper] run return fail

execute unless score @s skill.killer.trapper.count matches 3 function ./take_trap