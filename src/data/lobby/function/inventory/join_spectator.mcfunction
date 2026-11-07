advancement ./join_spectator {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{lobby.join_spectator: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./join_spectator)
    }
}

advancement revoke @s only ./join_spectator
clear @s
function game:spectator/spectate