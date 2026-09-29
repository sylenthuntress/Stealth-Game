## Manage start button
execute positioned 60 32 -0.5 if block ~ ~ ~ minecraft:acacia_button[powered=true] run function lobby:start_game:
    scoreboard objectives add var.players dummy
    execute store result score $players var.players run execute if entity @a
    execute unless score $time time.start_timer matches 0.. if score $players var.players matches 2.. run scoreboard players set $time time.start_timer 100
    execute unless score $time time.start_timer matches 0.. if score $players var.players matches ..1 run tellraw @a {"text":"Not enough players.","color":"red"}
    execute unless score $time time.start_timer matches 0.. if score $players var.players matches ..1 run playsound block.note_block.didgeridoo master @a ~ ~ ~ 1 0.5 1
    scoreboard objectives remove var.players

    execute if score $time time.start_timer matches 0..99 run title @a clear
    execute if score $time time.start_timer matches 0..99 run title @a title {"text":"Canceled.","color":"red"}
    execute if score $time time.start_timer matches 0..99 run playsound block.note_block.didgeridoo master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 0..99 run scoreboard players reset $time time.start_timer

    setblock ~ ~ ~ acacia_button[powered=false,face=wall,facing=south] destroy
execute if score $time time.start_timer matches 0.. run function render:time/start_timer/display:
    execute if score $time time.start_timer matches 100 run title @a title {"text": "Game is starting...","color":"gold"}

    execute if score $time time.start_timer matches 100 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"5","color":"red"}]
    execute if score $time time.start_timer matches 100 run playsound entity.arrow.hit_player master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 80 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"4","color":"red"}]
    execute if score $time time.start_timer matches 80 run playsound entity.arrow.hit_player master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 60 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"3","color":"red"}]
    execute if score $time time.start_timer matches 60 run playsound entity.arrow.hit_player master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 40 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"2","color":"red"}]
    execute if score $time time.start_timer matches 40 run playsound entity.arrow.hit_player master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 20 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"1","color":"red"}]
    execute if score $time time.start_timer matches 20 run playsound entity.arrow.hit_player master @a ~ ~ ~ 1 0.5 1
    execute if score $time time.start_timer matches 1 run title @a subtitle [{"text": "In: ","color":"gold"},{"text":"1","color":"red"}]
execute if score $time time.start_timer matches 0.. run scoreboard players remove $time time.start_timer 1
execute if score $time time.start_timer matches 0 run function game:start