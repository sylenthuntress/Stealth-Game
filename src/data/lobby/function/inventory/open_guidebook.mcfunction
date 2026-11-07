advancement ~/ {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{lobby.guidebook: true}"
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
function menu:guidebook/page/intro
playsound minecraft:item.book.page_turn ui @s ~ ~ ~ 1 1 1