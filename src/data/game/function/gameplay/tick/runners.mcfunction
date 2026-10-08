# Sneak to hide
execute if entity @s[predicate=util:is_sneaking] run scoreboard players add @s time.player.hide_timer 1
execute if entity @s[predicate=!util:is_sneaking] run scoreboard players set @s time.player.hide_timer 0
execute if score @s time.player.hide_timer matches 15 run function game:gameplay/runner/start_hiding:
    item fill entity @s armor.* with air
    effect give @s invisibility infinite 0 true
    attribute @s minecraft:camera_distance modifier add game:gameplay/runner/hiding 1.5 add_multiplied_base
    attribute @s minecraft:scale modifier add game:gameplay/runner/hiding -0.05 add_multiplied_base
    attribute @s minecraft:attack_damage modifier add game:gameplay/runner/hiding -1 add_multiplied_base
    attribute @s minecraft:movement_speed modifier add game:gameplay/runner/hiding 0.2 add_value
    attribute @s minecraft:jump_strength modifier add game:gameplay/runner/hiding -0.1 add_value
    attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value
    attribute @s minecraft:step_height modifier add game:gameplay/runner/hiding -0.3 add_value

    summon minecraft:item_display ~ ~ ~ {Tags:["little_mouse"], teleport_duration: 1, item: {components: {"minecraft:custom_name": {bold: 1b, color: "gold", italic: 0b, text: "Field Mouse", underlined: 1b}, "minecraft:lore": [{color: "gray", italic: 0b, text: "Custom Head ID: 110695"}, {color: "blue", italic: 0b, text: "www.minecraft-heads.com"}], "minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head"}
    execute as @e[type=item_display,tag=little_mouse,limit=1,sort=nearest] unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p uid.player
execute if score @s time.player.hide_timer matches 0 run function game:gameplay/runner/stop_hiding:
    effect clear @s invisibility
    attribute @s minecraft:camera_distance modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:scale modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:movement_speed modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:attack_damage modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:jump_strength modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:gravity modifier remove game:gameplay/runner/hiding
    attribute @s minecraft:step_height modifier remove game:gameplay/runner/hiding
    scoreboard players set @s time.player.hide_timer 0
    execute as @e[type=item_display,tag=little_mouse] if score @s uid.entity = @p uid.player run kill @s
    
execute as @e[type=item_display,tag=little_mouse] if score @s uid.entity = @p uid.player rotated as @p run tp @s ~ ~0.55 ~ ~180 0

# Manage Health
execute if score @s data.player.damage_taken matches 1.. run function game:gameplay/runner/take_damage
## Group healing
execute if entity @s[predicate=util:is_sneaking,scores={time.player.heal_timer=..0}] run scoreboard players set @s time.player.heal_timer 20
scoreboard players remove @s[predicate=!util:is_sneaking] time.player.heal_timer 1
execute if score @s[predicate=!util:is_sneaking] time.player.heal_timer matches 1.. if entity @a[distance=0.1..5,team=runner] run particle minecraft:happy_villager ~ ~ ~ 0.3 0.4 0.3 1 1 normal @a[scores={game.player.team_id=1}]
execute if score @s time.player.heal_timer matches 1 positioned ~-3 ~-1 ~-3 as @a[dx=6,dy=4,dz=6,team=runner,predicate=!util:is_sneaking,scores={time.player.heal_timer=2..,game.player.injury=1..}] at @s run function game:gameplay/mutual_health:
    scoreboard players add @s game.player.heal_amount 5
    function game:gameplay/runner/heal

    particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
    playsound minecraft:entity.bat.ambient player @a ~ ~ ~ 0.1 0.7

# Band crossing
execute if block ~ 41 ~ minecraft:diamond_block unless score @s game.player.band_progression >= @e[type=text_display,tag=band_display,limit=1,sort=nearest] segments.elapsed run function game:gameplay/runner/cross_band:
    scoreboard players add @s game.player.band_progression 1
    scoreboard players add @s game.player.due_points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression run scoreboard players add @s game.player.due_points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression run tellraw @a[tag=playing] {"translate": "game.cross_band", "color": "red", with: [["",{text:"#",color:"dark_red","bold":true},{score:{name:"@s",objective:"game.player.band_progression"},color:"dark_red","bold":true}]]}
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression run playsound block.note_block.chime master @a[tag=playing] ~ ~ ~ 1 0.5
    execute unless score @s game.player.band_progression > $gamestate gamestate.band_progression run playsound block.note_block.bit master @s ~ ~ ~ 1 0.5

    tag @s add self
    execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed <= @p[tag=self] game.player.band_progression run data modify entity @s text.color set value 'green'
    tag @s remove self
    
    scoreboard players operation $gamestate gamestate.band_progression > @s game.player.band_progression

execute if block ~ 41 ~ minecraft:netherite_block run function game:gameplay/runner/cross_finish:
    gamemode spectator
    team join finished
    tellraw @a {"translate": "game.cross_finish", "color": "red", with:[{"selector":"@s"}]}
    playsound minecraft:block.note_block.bell master @s ~ ~ ~ 2 1 1
    scoreboard players add @s game.player.due_points 50