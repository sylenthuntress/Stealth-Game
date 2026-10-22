import util:coordinates as coords

execute positioned coords.lobby.x coords.lobby.y coords.lobby.z if entity @s[distance=300..,gamemode=!creative,gamemode=!spectator] run function lobby:spawn

execute if score $gamestate gamestate.game_active matches 1 run item fill entity @s util:mid_hotbar with coal[
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