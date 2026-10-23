import util:coordinates as coords

execute positioned coords.lobby.x coords.lobby.y coords.lobby.z if entity @s[distance=300..,gamemode=!creative,gamemode=!spectator] run function lobby:spawn

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

execute if score @s lobby.credits.play_music matches 1.. run function ./../credits/eye_contact
execute positioned coords.credits.x (coords.credits.y+1.5) coords.credits.z at @s[distance=..3] anchored eyes facing coords.credits.x (coords.credits.y+1.5) coords.credits.z anchored feet positioned ^ ^ ^1 rotated as @s positioned ^ ^ ^-1 expand:
    if entity @s[distance=..0.5] unless score @s lobby.credits.play_music matches 1.. run function ./../credits/eye_contact
execute at @s anchored eyes facing coords.credits.x (coords.credits.y+1.5) coords.credits.z anchored feet positioned ^ ^ ^1 rotated as @s positioned ^ ^ ^-1 unless entity @s[distance=..0.5] unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:darkness":{}}}} run function ./../credits/stop_music