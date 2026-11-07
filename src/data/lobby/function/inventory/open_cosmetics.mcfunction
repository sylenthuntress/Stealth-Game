advancement ~/ {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{lobby.cosmetics: true}"
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
function cosmetic:selection/gui/main