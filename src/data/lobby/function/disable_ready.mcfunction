scoreboard players set @s lobby.ready 0
advancement revoke @s only lobby:ready_button/toggle_off
playsound minecraft:block.note_block.bell ui @s ~ ~ ~ 0.5 0.5
item fill entity @s util:mid_hotbar with red_stained_glass_pane[
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