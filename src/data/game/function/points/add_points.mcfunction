execute unless score @s game.player.due_points matches 1.. run return fail
execute unless score @s game.player.points matches 1.. run scoreboard players add $gamestate gamestate.ranked_players 1

scoreboard players operation @s game.player.due_points /= @s game.player.points_split
scoreboard players operation @s game.player.points += @s game.player.due_points
scoreboard players operation @s game.player.round_points += @s game.player.due_points

execute if score @s game.player.due_points matches 1.. run function game:points/log_points:
    # Create/update log entry based on player's name
    loot spawn ~ ~ ~ loot {type:"minecraft:generic",pools:[{rolls:1,entries:[{type:"minecraft:item",name:"minecraft:player_head"}]}],modifier:{type:"minecraft:fill_player_head",entity:"this"}}

    execute if score @s time.player.points_display_timer matches 1.. expand:
        execute store result storage points:data MergeData.points int 1 run scoreboard players get @s game.player.due_points
        scoreboard players remove @s scoredisplay.points_log.index 1
        execute store result storage points:data MergeData.index int 1 run scoreboard players get @s scoredisplay.points_log.index
        scoreboard players add @s scoredisplay.points_log.index 1
        function game:points/merge_old with storage points:data MergeData
        function game:points/merge_data with storage points:data MergeData
    execute unless score @s time.player.points_display_timer matches 1.. expand:
        data modify storage points:data PointsLog prepend value {}
        data modify storage points:data PointsLog[0].name set from entity @n[type=item] Item.components."minecraft:profile".name
        execute store result storage points:data PointsLog[0].points int 1 run scoreboard players get @s game.player.due_points
        execute store result storage points:data PointsLog[0].index int 1 run scoreboard players get @s scoredisplay.points_log.index
        scoreboard players add @s scoredisplay.points_log.index 1
    kill @n[type=item] # Kill player head
    
    # Limit amount of saved log entries
    scoreboard objectives add var.sidebar_space dummy
    scoreboard players set $var var.sidebar_space 10
    scoreboard players operation $var var.sidebar_space -= $gamestate gamestate.ranked_players

    scoreboard objectives add var.log_size dummy
    execute store result score $var var.log_size if data storage points:data PointsLog[]

    execute if score $var var.log_size > $var var.sidebar_space expand:
        function game:points/clear_log_entry with storage points:data PointsLog[-1]
        data remove storage points:data PointsLog[-1]
    execute if score $var var.log_size > $gamestate gamestate.ranked_players expand:
        function game:points/clear_log_entry with storage points:data PointsLog[-1]
        data remove storage points:data PointsLog[-1]
    scoreboard objectives remove var.log_size
    scoreboard objectives remove var.sidebar_space

    # Display all saved log entries
    execute if data storage points:data PointsLog[0] expand:
        scoreboard players set $scoredisplay game.player.points -999999
        scoreboard players display numberformat $scoredisplay game.player.points fixed {"text":"|  ","color":"dark_gray"}
        scoreboard players display name $scoredisplay game.player.points {
            "translate": "game.sidebar.point_log",
            "color": "dark_gray",
            "bold": true
        }
    data modify storage points:data Recursive set from storage points:data PointsLog
    execute function game:points/display_log:
        function game:points/display_log_entry with storage points:data Recursive[-1]
        data remove storage points:data Recursive[-1]
        execute if data storage points:data Recursive[-1] run function game:points/display_log

    scoreboard players reset @s game.player.due_points

scoreboard players set @s time.player.points_display_timer 200
scoreboard players set @a[scores={time.player.points_display_timer=1..}] time.player.points_display_timer 200
execute as @a[scores={time.player.points_display_timer=1..}] run function render:points/make_numberformat

scoreboard players reset @s game.player.due_points