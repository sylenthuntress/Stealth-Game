

tag @s add this.selector
execute as @e[type=snowball,tag=skill.runner_skill.alchemist.blinding_flask] at @s run function ./tick_blinding_flask:
    execute on origin run tag @s add this.selected
    execute if entity @a[tag=this.selected,tag=this.selector] if entity @a[team=killer,distance=..3] function ./land_blinding_flask:
            effect give @a[team=killer,distance=..3] minecraft:blindness 5 0 false
            effect give @a[team=killer,distance=..3] minecraft:darkness 5 0 false
            scoreboard players add this.selected time.player.assist_timer 240

            tellraw @a[tag=game.playing] {"translate":"skill.runner.alchemist.land_blinding_flask","color":"#5c3561","with":[{"selector":"@a[team=killer,distance=..3]"}]}
            particle minecraft:large_smoke ~ ~ ~ 0.4 0.4 0.4 0.01 32 normal @a
            playsound minecraft:block.glass.break player @a ~ ~ ~ 1 1.7
            playsound minecraft:entity.squid.squirt player @a ~ ~ ~ 1 2
            kill @s
            execute on passengers run kill @s
    tag @a remove this.selected

execute as @e[type=snowball,tag=skill.runner_skill.alchemist.stagger_flask] at @s run function ./tick_stagger_flask:
    execute on origin run tag @s add this.selected
    execute if entity @a[tag=this.selected,tag=this.selector] if entity @a[team=killer,distance=..3] function ./land_stagger_flask:
            scoreboard players add @a[team=killer,distance=..3] time.player.stun_timer 50
            scoreboard players add this.selected time.player.assist_timer 120

            tellraw @a[tag=game.playing] {"translate":"skill.runner.alchemist.land_stagger_flask","color":"#933f2e","with":[{"selector":"@a[team=killer,distance=..3]"}]}
            particle minecraft:crit ~ ~ ~ 0.4 0.4 0.4 0.01 32 normal @a
            playsound minecraft:block.glass.break player @a ~ ~ ~ 1 1.7
            playsound minecraft:entity.squid.squirt player @a ~ ~ ~ 1 2
            kill @s
            execute on passengers run kill @s
    tag @a remove this.selected
tag @s remove this.selector

execute as @e[type=marker,tag=skill.runner_skill.alchemist.flask] at @s unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{vehicle:{}}} function ./miss_flask:
    playsound minecraft:block.glass.break player @a ~ ~ ~ 1 0.8
    kill @s

execute if score @s skill.runner.alchemist.cooldown matches 1.. run function ./tick_cooldown:
    scoreboard players remove @s skill.runner.alchemist.cooldown 1

    scoreboard players operation $display time.display_sec = @s skill.runner.alchemist.cooldown
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s ./blinding_flask ./disable_blinding_flask
    item modify entity @s ./stagger_flask ./disable_stagger_flask
    item modify entity @s ./blinding_flask_cooldown ./set_cooldown
    item modify entity @s ./stagger_flask_cooldown ./set_cooldown

    execute if score @s skill.runner.alchemist.cooldown matches 0 at @s run function ./end_cooldown:
        scoreboard players reset @s skill.runner.alchemist.cooldown
        item modify entity @s ./blinding_flask_cooldown ./enable_blinding_flask
        item modify entity @s ./stagger_flask_cooldown ./enable_stagger_flask
        playsound minecraft:block.brewing_stand.brew player @s ~ ~ ~ 1 1.5