advancement ~/ {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{lobby.ready_button.ready: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (~/)
    }
}

scoreboard players set @s lobby.ready 0
advancement revoke @s only ~/
playsound minecraft:block.note_block.bell ui @s ~ ~ ~ 0.5 0.5