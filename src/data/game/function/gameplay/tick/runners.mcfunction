# Movement speed
attribute @s[predicate=!util:is_sprinting] minecraft:movement_speed modifier add minecraft:sprinting 0.3 add_multiplied_base

# Sneak to hide
execute if entity @s[predicate=util:is_sneaking] if score @s time.player.hide_timer matches ..15 run scoreboard players add @s time.player.hide_timer 1
execute if score @s time.player.hide_timer matches 16.. run scoreboard players remove @s time.player.hide_timer 1
execute if entity @s[predicate=!util:is_sneaking] if score @s time.player.hide_timer matches 1.. run scoreboard players remove @s time.player.hide_timer 1
execute if score @s[tag=!hiding] time.player.hide_timer matches 15 run function game:gameplay/runner/start_hiding:
    tag @s add hiding
    particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
    item fill entity @s armor.* with air
    effect give @s invisibility infinite 0 true
    attribute @s minecraft:camera_distance modifier add game:gameplay/runner/hiding 1.5 add_multiplied_base
    attribute @s minecraft:scale modifier add game:gameplay/runner/hiding -0.05 add_multiplied_base
    attribute @s minecraft:attack_damage modifier add game:gameplay/runner/hiding -1 add_multiplied_base
    attribute @s minecraft:sneaking_speed modifier add game:gameplay/runner/hiding 0.7 add_value
    attribute @s minecraft:jump_strength modifier add game:gameplay/runner/hiding -0.1 add_value
    attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value
    attribute @s minecraft:step_height modifier add game:gameplay/runner/hiding -0.3 add_value

    summon minecraft:item_display ~ ~ ~ {Tags:["little_mouse"], teleport_duration: 1, item: {components: {"minecraft:custom_name": {bold: 1b, color: "gold", italic: 0b, text: "Field Mouse", underlined: 1b}, "minecraft:lore": [{color: "gray", italic: 0b, text: "Custom Head ID: 110695"}, {color: "blue", italic: 0b, text: "www.minecraft-heads.com"}], "minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head"}
    execute as @e[type=item_display,tag=little_mouse,limit=1,sort=nearest] unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p uid.player
    rotate @e[type=item_display,tag=little_mouse,limit=1,sort=nearest] ~180 0
    tp @e[type=item_display,tag=little_mouse,limit=1,sort=nearest] ~ ~0.55 ~
execute if score @s[tag=hiding] time.player.hide_timer matches 0 run function game:gameplay/runner/stop_hiding:
    tag @s remove hiding
    particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
    effect clear @s invisibility
    attribute @s minecraft:camera_distance modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:scale modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:sneaking_speed modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:attack_damage modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:jump_strength modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:gravity modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:step_height modifier remove game:gameplay/runner/hiding
    scoreboard players set @s time.player.hide_timer 0
    execute as @e[type=item_display,tag=little_mouse] if score @s uid.entity = @p uid.player run kill @s

tag @s add this.self
execute positioned ~ ~0.55 ~ as @e[type=item_display,tag=little_mouse,distance=0.001..] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run tag @s add this.selected
execute as @e[type=item_display,tag=this.selected,limit=1] run rotate @s facing entity @a[tag=this.self,limit=1] eyes
execute as @e[type=item_display,tag=this.selected,limit=1] at @s run rotate @s ~180 0
execute as @e[type=item_display,tag=this.selected,limit=1] run tp @s ~ ~0.55 ~
tag @e remove this.selected
tag @s remove this.self

# Manage Health
execute if score @s data.player.damage_taken matches 1.. run function game:gameplay/runner/take_damage
execute if score @s time.player.damage_timer matches 1.. run scoreboard players remove @s time.player.damage_timer 1
execute if score @s time.player.damage_timer matches 0 expand:
    attribute @s minecraft:movement_speed modifier remove game:gameplay/runner/damaged
    scoreboard players reset @s time.player.damage_timer

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
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression expand:
        scoreboard players add @s game.player.due_points 5
        scoreboard players reset @s time.player.assist_timer
        scoreboard players add @a[scores={time.player.assist_timer=1..}] game.player.due_points 5
        tellraw @a[tag=playing] {"translate": "game.cross_band", "color": "red", with: [["",{text:"#",color:"dark_red","bold":true},{score:{name:"@s",objective:"game.player.band_progression"},color:"dark_red","bold":true}]]}
        as @a at @s run playsound block.note_block.chime master @s ~ ~ ~ 1 0.5
    execute unless score @s game.player.band_progression > $gamestate gamestate.band_progression run playsound block.note_block.bit master @s ~ ~ ~ 1 0.5

    tag @s add self
    execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed <= @p[tag=self] game.player.band_progression run data modify entity @s text.color set value 'green'
    tag @s remove self
    
    scoreboard players operation $gamestate gamestate.band_progression > @s game.player.band_progression
    function skill:cross_band

execute if block ~ 41 ~ minecraft:netherite_block run function game:gameplay/runner/cross_finish:
    gamemode spectator
    team join finished
    playsound minecraft:block.note_block.bell master @a ~ ~ ~ 2 1 1

    scoreboard players add @s game.player.due_points 50
    execute unless score $gamestate gamestate.crossed_finish matches 1 scoreboard players add @s game.player.due_points 5
    execute unless score $gamestate gamestate.crossed_finish matches 1 scoreboard players set $time time.endgame_timer 600
    scoreboard players set $gamestate gamestate.crossed_finish 1
    bossbar set game:time/round_timer players
    bossbar set game:time/endgame_timer players @a[tag=playing]
    execute store result bossbar game:time/endgame_timer value run scoreboard players get $time time.endgame_timer
    
    execute unless score @s skill.runner.medic.revive_uid matches 0.. run tellraw @a {"translate": "game.cross_finish", "color": "red", with:[{"selector":"@s"}]}
    execute if score @s skill.runner.medic.revive_uid matches 0.. run function skill:runner_skill/medic/award_points

    execute as @e[type=text_display,tag=band_display] run data modify entity @s text.color set value 'gold'
