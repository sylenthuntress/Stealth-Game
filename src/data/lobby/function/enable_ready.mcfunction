scoreboard players set @s lobby.ready 1
advancement revoke @s only lobby:ready_button/toggle_on
playsound minecraft:block.note_block.bell ui @s ~ ~ ~ 0.5 1
item fill entity @s util:mid_hotbar with lime_stained_glass_pane[
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