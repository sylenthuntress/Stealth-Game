from bolt_expressions import Scoreboard, Data
timer = Scoreboard.objective("time.start_sequence")

execute if score $time time.start_sequence matches 1.. run scoreboard players remove $time time.start_sequence 1

# Play final warning sounds as timer reaches zero
scoreboard objectives add var.timer_modulo dummy
timerModulo = Scoreboard("var.timer_modulo")
timerModulo["$var"] = timer["$time"] % 20

execute if score $time time.start_sequence matches 1..100 if score $var timerModulo matches 0 as @a[tag=playing] at @s run playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 2 0.5
scoreboard objectives remove var.timer_modulo

# Fully start round
execute if score $time time.start_sequence matches 0 run function game:round/start