import util:coordinates as coords
# Reset
scoreboard players set @s lobby.ready 1
gamemode adventure
effect clear @s
effect give @s weakness infinite 255 true
effect give @s resistance infinite 255 true
effect give @s saturation infinite 255 true

# Fill hotbar
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

# Teleport
teleport coords.lobby.x coords.lobby.y coords.lobby.z