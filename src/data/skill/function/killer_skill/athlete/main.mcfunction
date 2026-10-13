scoreboard players remove @s[tag=skill.killer_skill.athlete.dashing] skill.killer.athlete.dash_timer 1
scoreboard players remove @s[tag=skill.killer_skill.athlete.dashing] time.player.stun_timer 1
execute if score @s skill.killer.athlete.cooldown matches 1.. run function skill:killer_skill/athlete/tick_cooldown:
    scoreboard players remove @s skill.killer.athlete.cooldown 1

    scoreboard players operation $display time.display_sec = @s skill.killer.athlete.cooldown
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s skill:killer_skill/athlete/cooldown skill:killer_skill/athlete/set_cooldown

    execute if score @s skill.killer.athlete.cooldown matches 0 run function skill:killer_skill/athlete/end_cooldown:
        scoreboard players reset @s skill.killer.athlete.cooldown
        item fill entity @s skill:killer_skill/athlete/cooldown with minecraft:feather[
        custom_name={
            "color": "#9dfff5",
            "translate": "skill.killer.athlete.ability",
            "italic": false,
            "with": [
                {
                    "sprite": "minecraft:mob_effect/speed",
                    "atlas": "minecraft:gui",
                    "color": "white"
                }
            ]
        },
        consumable={
            consume_seconds: 0.05,
            has_consume_particles: false,
            animation: "bow",
            sound:{sound_id:""}
        },
        custom_data={
            skill.killer.athlete.ability: true
        },
        minecraft:item_model="hide_and_squeak:dash"
    ]

execute if score @s skill.killer.athlete.dash_timer matches 1.. run function skill:killer_skill/athlete/start_dashing:
    tag @s add skill.killer_skill.athlete.dashing
    attribute @s minecraft:movement_speed modifier add game:killer_skill/athlete/dashing 1.5 add_multiplied_base
    attribute @s minecraft:friction_modifier modifier add game:killer_skill/athlete/dashing -1.5 add_multiplied_base
    attribute @s minecraft:step_height modifier add game:killer_skill/athlete/dashing 1 add_value

execute if score @s skill.killer.athlete.dash_timer matches 0 run function skill:killer_skill/athlete/stop_dashing:
    scoreboard players reset @s skill.killer.athlete.dash_timer
    tag @s remove skill.killer_skill.athlete.dashing
    attribute @s minecraft:movement_speed modifier remove game:killer_skill/athlete/dashing
    attribute @s minecraft:friction_modifier modifier remove game:killer_skill/athlete/dashing
    attribute @s minecraft:step_height modifier remove game:killer_skill/athlete/dashing