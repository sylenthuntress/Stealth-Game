# Movement speed
attribute @s[predicate=!util:is_sprinting] minecraft:movement_speed modifier add minecraft:sprinting 0.3 add_multiplied_base

# Sneak to hide
execute function game:gameplay/runner/tick_hiding:
    execute if entity @s[predicate=util:is_sneaking] if score @s time.player.hide_timer matches ..15 run scoreboard players add @s time.player.hide_timer 1
    execute if score @s time.player.hide_timer matches 16.. run scoreboard players remove @s time.player.hide_timer 1
    execute if entity @s[predicate=!util:is_sneaking] if score @s time.player.hide_timer matches 1.. run scoreboard players remove @s time.player.hide_timer 1
    execute if score @s[tag=!hiding] time.player.hide_timer matches 15 run function game:gameplay/runner/start_hiding
    execute if score @s[tag=hiding] time.player.hide_timer matches 0 run function game:gameplay/runner/stop_hiding

    execute if entity @s[tag=!hiding] run return fail

    tag @s add this.self
    execute as @e[type=item_display,tag=little_mouse] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run tag @s add this.display
    execute positioned ~ ~0.55 ~ as @n[type=item_display,tag=this.display,distance=0.1..] expand:
        rotate @s facing entity @a[tag=this.self,limit=1] eyes
        at @s run rotate @s ~180 0
        tp @s ~ ~ ~

    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:glowing":{}}}} run function game:gameplay/runner/glow_hiding:
        execute store result score #var time.entity.glow_timer run data get entity @s active_effects[{id:"minecraft:glowing"}].duration
        scoreboard players operation @n[type=item_display,tag=this.display] time.entity.glow_timer += #var time.entity.glow_timer
        scoreboard players reset #var time.entity.glow_timer
        data merge entity @n[type=item_display,tag=this.display] {Glowing:1b}
        effect clear @s minecraft:glowing
    scoreboard players remove @n[type=item_display,tag=this.display,scores={time.entity.glow_timer=1..}] time.entity.glow_timer 1
    execute as @n[type=item_display,tag=this.display] if score @s time.entity.glow_timer matches ..0 expand:
        data merge entity @s {Glowing:0b}
        scoreboard players reset @s time.entity.glow_timer

    tag @e remove this.display
    tag @s remove this.self

# Manage Health
execute if score @s data..damage_taken matches 1.. run function game:gameplay/runner/take_damage
execute if score @s time.player.damage_timer matches 1.. run scoreboard players remove @s time.player.damage_timer 1
execute if score @s time.player.damage_timer matches 0 expand:
    attribute @s minecraft:movement_speed modifier remove game:gameplay/runner/damaged
    scoreboard players reset @s time.player.damage_timer
scoreboard players operation @s game.player.prev_damage = @s game.player.damage

## Group healing
execute if predicate util:is_sneaking unless score @s game.player.dance_state matches 1.. expand:
    scoreboard players set @s time.player.dance_timer 20
    scoreboard players set @s game.player.dance_state 1
execute unless predicate util:is_sneaking if score @s game.player.dance_state matches 1 expand:
    scoreboard players set @s time.player.dance_timer 20
    scoreboard players set @s game.player.dance_state 2
execute if predicate util:is_sneaking if score @s game.player.dance_state matches 2 expand: 
    unless score @s time.player.heal_timer matches 1.. run scoreboard players set @s time.player.heal_timer 20
    scoreboard players set @s game.player.dance_state 0
scoreboard players remove @s time.player.dance_timer 1
execute if score @s time.player.dance_timer matches 0 run scoreboard players set @s game.player.dance_state 0

scoreboard players remove @s time.player.heal_timer 1
execute if score @s time.player.heal_timer matches 1.. if entity @a[distance=0.1..5,team=runner] run particle minecraft:happy_villager ~ ~ ~ 0.3 0.4 0.3 1 1 normal @a[scores={game.player.team_id=1}]
execute if score @s time.player.heal_timer matches 1 positioned ~-3 ~-1 ~-3 as @a[dx=6,dy=4,dz=6,team=runner,scores={time.player.heal_timer=2..,game.player.injury=1..}] at @s run function game:gameplay/mutual_health:
    scoreboard players add @s game.player.heal_amount 5
    function game:gameplay/runner/heal

    particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
    playsound minecraft:entity.bat.ambient player @a ~ ~ ~ 0.1 0.7

# Band crossing
execute if block ~ 41 ~ minecraft:diamond_block unless score @s game.player.band_progression >= @e[type=text_display,tag=band_display,limit=1,sort=nearest] segments.elapsed run function game:gameplay/runner/cross_band:
    scoreboard players add @s game.player.band_progression 1
    scoreboard players add @s game.player.due_points 5
    execute if score @s game.player.band_progression > #gamestate gamestate.band_progression expand:
        scoreboard players add @s game.player.due_points 5
        scoreboard players reset @s time.player.assist_timer
        scoreboard players add @a[scores={time.player.assist_timer=1..}] game.player.due_points 5
        tellraw @a[tag=game.viewing] {"translate": "game.cross_band", "color": "red", with: [["",{text:"#",color:"dark_red","bold":true},{score:{name:"@s",objective:"game.player.band_progression"},color:"dark_red","bold":true}]]}
        as @a at @s run playsound block.note_block.chime master @s ~ ~ ~ 1 0.5
    execute unless score @s game.player.band_progression > #gamestate gamestate.band_progression run playsound block.note_block.bit master @s ~ ~ ~ 1 0.5

    tag @s add self
    execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed <= @p[tag=self] game.player.band_progression run data modify entity @s text.color set value 'green'
    tag @s remove self
    
    scoreboard players operation #gamestate gamestate.band_progression > @s game.player.band_progression
    function skill:cross_band
    execute as @a run function #skill:event/band_claimed

execute if block ~ 41 ~ minecraft:netherite_block run function game:gameplay/runner/cross_finish:
    gamemode spectator
    team join finished
    playsound minecraft:block.note_block.bell master @a ~ ~ ~ 2 1 1

    scoreboard players operation #math game.player.due_points = #segments segments.elapsed
    scoreboard players operation #math game.player.due_points *= #10 math.const
    scoreboard players operation #math game.player.due_points /= #2 math.const
    execute if score #gamestate gamestate.crossed_finish matches 1 run scoreboard players remove #math game.player.due_points 10
    scoreboard players operation @s game.player.due_points += #math game.player.due_points

    execute unless score #gamestate gamestate.crossed_finish matches 1 scoreboard players set #time time.endgame_timer 600
    scoreboard players set #gamestate gamestate.crossed_finish 1
    bossbar set game:time/round_timer players
    bossbar set game:time/endgame_timer players @a[tag=game.viewing]
    execute store result bossbar game:time/endgame_timer value run scoreboard players get #time time.endgame_timer
    
    execute unless score @s skill.runner.medic.revive_uid matches 0.. run tellraw @a {"translate": "game.cross_finish", "color": "red", with:[{"selector":"@s"}]}
    execute if score @s skill.runner.medic.revive_uid matches 0.. run function skill:runner_skill/medic/award_points

    function skill:disable_skills
    execute as @e[type=text_display,tag=band_display] run data modify entity @s text.color set value 'gold'
