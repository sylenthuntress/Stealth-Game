# Make point display more fancy
execute as @s[tag=playing] run function render:points/make_displayname

execute if score @s time.player.points_display_timer matches 0 expand:
    function render:points/make_numberformat
    scoreboard players reset @s time.player.points_display_time
execute if score @s time.player.points_display_timer matches 1.. run scoreboard players remove @s time.player.points_display_timer 1