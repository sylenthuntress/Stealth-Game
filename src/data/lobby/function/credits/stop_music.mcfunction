stopsound @s * minecraft:music.credits
stopsound @s * minecraft:music.disc.11
execute if score @s lobby.credits.play_music matches 30.. run playsound minecraft:item.axe.scrape master @s ~ ~ ~ 1 2

scoreboard players reset @s lobby.credits.play_music