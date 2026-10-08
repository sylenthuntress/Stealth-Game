advancement revoke @s only skill:killer_skill/athlete/use_dash
scoreboard players set @s time.player.dash_cooldown 300
scoreboard players set @s time.player.dash_timer 100

item fill entity @s skill:killer_skill/athlete/dash_item with minecraft:barrier[
    custom_name={
        "color": "#5c5c5c",
        "translate": "skill.killer.athlete.dash_cooldown",
        "italic": true,
        "with": [
            {
                "sprite": "minecraft:mob_effect/speed",
                "atlas": "minecraft:gui"
            }
        ]
    },
    minecraft:custom_data={
        "skill.killer.athlete.dash_cooldown":true
    }
]

playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 2 1 0.1