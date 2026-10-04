# Manage Health
execute if score @s data.player.damage_taken matches 1.. run function game:gameplay/runner/take_damage
## Group healing
execute if entity @s[predicate=util:is_sneaking,scores={time.player.heal_timer=..0}] run scoreboard players set @s time.player.heal_timer 20
scoreboard players remove @s[predicate=!util:is_sneaking] time.player.heal_timer 1
execute if score @s[predicate=!util:is_sneaking] time.player.heal_timer matches 1.. if entity @a[distance=0.1..5] run particle minecraft:happy_villager ~ ~ ~ 0.3 0.4 0.3 1 1 normal @a[scores={game.player.team_id=1}]
execute if score @s time.player.heal_timer matches 1 positioned ~-3 ~-1 ~-3 as @a[dx=6,dy=4,dz=6,predicate=!util:is_sneaking,scores={time.player.heal_timer=2..,game.player.injury=1..}] at @s run function game:gameplay/mutual_health:
    scoreboard players add @s game.player.heal_amount 5
    function game:gameplay/runner/heal

    particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
    playsound minecraft:entity.bat.ambient player @a ~ ~ ~ 0.1 0.7

# Band crossing
execute if block ~ 41 ~ minecraft:diamond_block unless score @s game.player.band_progression >= @e[type=text_display,tag=band_display,limit=1,sort=nearest] segments.elapsed run function game:gameplay/runner/cross_band:
    scoreboard players add @s game.player.band_progression 1
    scoreboard players add @s game.player.points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression run scoreboard players add @s game.player.points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression as @a[tag=playing] run tellraw @s {"translate": "game.cross_band", "color": "red", with: [{"score":{"name":"@s","objective":"game.player.band_progression"}}]}
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression as @a[tag=playing] run playsound block.note_block.chime master @s ~ ~ ~ 2 0
    execute unless score @s game.player.band_progression > $gamestate gamestate.band_progression run playsound block.note_block.bit master @s ~ ~ ~ 2 0

    tag @s add self
    execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed <= @p[tag=self] game.player.band_progression run data modify entity @s text.color set value 'green'
    tag @s remove self
    
    scoreboard players operation $gamestate gamestate.band_progression > @s game.player.band_progression