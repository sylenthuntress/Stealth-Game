# Tick subtasks
function lobby:tick/main
function level:tick/main
execute as @a run function skill:tick
execute if score #gamestate gamestate.game_active matches 1 run function game:tick/main
execute as @e[type=item] run function items:dropped/tick

# Handle new players
execute as @a unless score @s uid.player matches 0.. run function main:first_join
execute as @a[scores={data.player.leave_game=1..}] run function main:consecutive_join

# Reset data collection at end of tree
## (Appended from setup:scores#Data)