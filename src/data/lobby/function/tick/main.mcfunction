# Tick subtasks
execute as @a[tag=lobby] run function lobby:tick/player

# Manage start button
execute positioned 60 32 -0.5 if block ~ ~ ~ minecraft:acacia_button[powered=true] run function lobby:start_game:
    execute if score #gamestate gamestate.game_active matches 1 run return run function lobby:ongoing_match:
        tellraw @a[tag=lobby] {"text":"Match in progress.","color":"red"}
        playsound block.note_block.didgeridoo master @a[tag=lobby] ~ ~ ~ 1 0.5 1
        setblock ~ ~ ~ acacia_button[powered=false,face=wall,facing=south] destroy
        return fail

    scoreboard objectives add var.players dummy
    execute store result score #players var.players run execute if entity @a[scores={lobby.ready=1}]
    execute unless score #time time.start_timer matches 0.. if score #players var.players matches 2.. run scoreboard players set #time time.start_timer 100
    execute unless score #time time.start_timer matches 0.. if score #players var.players matches ..1 run tellraw @a {"text":"Not enough players.","color":"red"}
    execute unless score #time time.start_timer matches 0.. if score #players var.players matches ..1 run playsound block.note_block.didgeridoo master @a ~ ~ ~ 1 0.5 1
    scoreboard objectives remove var.players

    execute if score #time time.start_timer matches 0..99 run function lobby:cancel_game:
        title @a clear
        title @a title {"text":"Canceled.","color":"red"}
        playsound block.note_block.didgeridoo master @a ~ ~ ~ 1 0.5 1
        scoreboard players reset #time time.start_timer

    setblock ~ ~ ~ acacia_button[powered=false,face=wall,facing=south] destroy

execute if score #time time.start_timer matches 0.. run function lobby:countdown:
    execute if score #time time.start_timer matches 100 run title @a title {"text": "Game is starting...","color":"gold"}

    execute if score #time time.start_timer matches 100 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"5","color":"red"}]
    execute if score #time time.start_timer matches 100 as @a[scores={lobby.ready=1}] run playsound entity.arrow.hit_player master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 80 as @a[scores={lobby.ready=0}] run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 80 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"4","color":"red"}]
    execute if score #time time.start_timer matches 80 as @a[scores={lobby.ready=1}] run playsound entity.arrow.hit_player master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 60 as @a[scores={lobby.ready=0}] run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 60 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"3","color":"red"}]
    execute if score #time time.start_timer matches 60 as @a[scores={lobby.ready=1}] run playsound entity.arrow.hit_player master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 40 as @a[scores={lobby.ready=0}] run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 40 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"2","color":"red"}]
    execute if score #time time.start_timer matches 40 as @a[scores={lobby.ready=1}] run playsound entity.arrow.hit_player master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 20 as @a[scores={lobby.ready=0}] run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 20 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"1","color":"red"}]
    execute if score #time time.start_timer matches 20 as @a[scores={lobby.ready=1}] run playsound entity.arrow.hit_player master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 1 as @a[scores={lobby.ready=0}] run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1 0.5 1
    execute if score #time time.start_timer matches 1 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"1","color":"red"}]

    scoreboard players remove #time time.start_timer 1
    scoreboard objectives add var.players dummy
    execute store result score #players var.players run execute if entity @a[scores={lobby.ready=1}]
    execute if score #players var.players matches ..1 run function lobby:cancel_game
    scoreboard objectives remove var.players
execute if score #time time.start_timer matches 0 run function game:new_match