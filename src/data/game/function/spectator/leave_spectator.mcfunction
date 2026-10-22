playsound minecraft:entity.phantom.death ui @s ~ ~ ~ 0.5 2 0.5
scoreboard players reset @s game.player.leave_spectator
function lobby:join_lobby

execute if score $gamestate gamestate.round_active matches 1 expand:
    unless score $time time.endgame_timer matches 1.. run bossbar set game:time/round_timer players @a[tag=game.viewing]
    if score $time time.endgame_timer matches 1.. run bossbar set game:time/endgame_timer players @a[tag=game.viewing]