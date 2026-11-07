advancement ~/ {
  "criteria": {
    "condition": {
      "trigger": "minecraft:inventory_changed"
    }
  },
  "rewards": {
    "function": (~/)
  }
}

execute if entity @s[tag=!lobby,gamemode=adventure] run return run advancement revoke @s only ~/
clear @s

item replace entity @s hotbar.1 with minecraft:book[
    custom_name={
        "color": "#ca8446",
        "translate": "lobby.guidebook",
        "italic": false
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        lobby.guidebook: true
    },
    max_stack_size=1
]
item replace entity @s hotbar.7 with minecraft:leather_helmet[
    custom_name={
        "color": "#9e6ea7",
        "translate": "lobby.cosmetics",
        "italic": false
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        lobby.cosmetics: true
    },
    max_stack_size=1
]

execute if score #gamestate gamestate.game_active matches 0 expand:
    item fill entity @s[scores={lobby.ready=1}] util:mid_hotbar with lime_stained_glass_pane[
        custom_name={
            "color": "#4dca46",
            "translate": "lobby.ready_button.ready",
            "italic": false
        },
        consumable={
            consume_seconds: 0.05,
            has_consume_particles: false,
            animation: "bow",
            sound:{sound_id:""}
        },
        custom_data={
            lobby.ready_button.ready: true
        },
        max_stack_size=1,
        minecraft:item_model="hide_and_squeak:ready"
    ]
    item fill entity @s[scores={lobby.ready=0}] util:mid_hotbar with red_stained_glass_pane[
        custom_name={
            "color": "#ca4646",
            "translate": "lobby.ready_button.not_ready",
            "italic": false
        },
        consumable={
            consume_seconds: 0.05,
            has_consume_particles: false,
            animation: "bow",
            sound:{sound_id:""}
        },
        custom_data={
            lobby.ready_button.not_ready: true
        },
        max_stack_size=1,
        minecraft:item_model="hide_and_squeak:not_ready"
    ]

execute if score #gamestate gamestate.game_active matches 1 run item fill entity @s util:mid_hotbar with coal[
    custom_name={
        "color": "#818181",
        "translate": "lobby.join_spectator",
        "italic": false
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        lobby.join_spectator: true
    },
    max_stack_size=1,
    minecraft:item_model="hide_and_squeak:spectator"
]

advancement revoke @s only ~/