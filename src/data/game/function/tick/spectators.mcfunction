import util:coordinates as coords

execute if block ~ 41 ~ minecraft:black_concrete expand:
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5 1
    tp @s @s
    tp @s[x=(coords.play_area.x+70),dx=-100] ~-6 ~ ~
    tp @s[x=(coords.play_area.x-70),dx=100] ~6 ~ ~

execute positioned ~ (coords.play_area.y+35) ~ if entity @s[dy=100] expand:
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5 1
    tp @s @s
    tp ~ ~-6 ~

execute positioned ~ (coords.play_area.y-18) ~ if entity @s[dy=-100] expand:
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5 1
    tp ~ ~6 ~
    tp @s @s

execute positioned ~ ~ (coords.play_area.z-15) if entity @s[dz=-100] expand:
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5 1
    tp @s @s
    tp ~ ~ ~6

execute at @e[type=marker,tag=gameplay.killer.backdoor.final_warp] positioned ~-34 41 ~10 if entity @s[dz=100,dy=100,dx=100] expand:
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5 1
    tp @s @s
    at @s run tp ~ ~ ~-6
