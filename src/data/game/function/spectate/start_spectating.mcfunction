import util:coordinates as coords
teleport @s coords.loading.x (coords.loading.y-20) coords.loading.z

gamemode spectator
team join spectator
tag @s add game.viewing
scoreboard players set @s game.player.spectating 1
scoreboard players enable @s game.player.leave_spectator

playsound minecraft:entity.arrow.hit_player ui @s ~ ~ ~ 0.5 1 0.5
tellraw @s {translate:"game.player.spectator",color:"gray",with:[{translate:"game.player.leave_spectate",color:"dark_gray",bold:true,click_event:{action:"run_command",command:"trigger game.player.leave_spectator set 1"}}]}

execute if score $gamestate gamestate.round_active matches 1 expand:
    unless score $time time.endgame_timer matches 1.. run bossbar set game:time/round_timer players @a[tag=game.viewing]
    if score $time time.endgame_timer matches 1.. run bossbar set game:time/endgame_timer players @a[tag=game.viewing]