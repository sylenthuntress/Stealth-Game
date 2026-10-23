execute if predicate {type:"minecraft:random_chance",chance:0.01} run return run function ./play_scary_music:
    playsound minecraft:music_disc.11 record @s ~ ~ ~ 0.5 2 0.5
    effect give @s minecraft:nausea 35 5 false
    effect give @s minecraft:darkness 35 5 false
    effect give @s minecraft:blindness 35 5 false
    effect give @s minecraft:slowness 35 255 true
    effect give @s minecraft:invisibility 35 255 true
    dialog clear @s
playsound minecraft:music.credits record @s ~ ~ ~ 1 1 1