# Manage Health
execute if entity @s[scores={data.player.health=..98}] run function game:gameplay/take_damage

# Band crossing
execute if block ~ 45 ~ minecraft:diamond_block unless score @s game.player.band_progression >= @e[type=text_display,tag=band_display,limit=1,sort=nearest] segments.elapsed run function game:gameplay/cross_band:
    scoreboard players add @s game.player.band_progression 1
    scoreboard players add @s game.player.points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression run scoreboard players add @s game.player.points 5
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression as @a[tag=playing] run tellraw @s {"translate": "game.cross_band", "color": "red", with: [{"score":{"name":"@s","objective":"game.player.band_progression"}}]}
    execute if score @s game.player.band_progression > $gamestate gamestate.band_progression as @a[tag=playing] run playsound block.note_block.chime master @s ~ ~ ~ 2 0
    execute unless score @s game.player.band_progression > $gamestate gamestate.band_progression run playsound block.note_block.bit master @s ~ ~ ~ 2 0

    data modify entity @e[type=text_display,tag=band_display,limit=1,sort=nearest] text.color set value 'green'
    scoreboard players operation $gamestate gamestate.band_progression > @s game.player.band_progression