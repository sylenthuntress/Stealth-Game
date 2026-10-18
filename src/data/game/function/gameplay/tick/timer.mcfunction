from bolt_expressions import Scoreboard, Data

execute unless score $time time.endgame_timer matches 1.. run return run function game:gameplay/tick/round_timer:
    timer = Scoreboard.objective("time.round_timer")
    # Increment timer
    execute if score $time timer matches 1.. run scoreboard players remove $time timer 1
    scoreboard objectives add var.timer_modulo dummy
    timerModulo = Scoreboard("var.timer_modulo")
    timerModulo["$var"] = timer["$time"] % 20

    execute if score $var timerModulo matches 0 store result bossbar game:time/round_timer value run scoreboard players get $time timer

    # End game if timer reaches zero
    execute if score $time timer matches 0 run return run function game:round/timeout

    execute function render:time/round_timer/display:
        # Update bossbar name to reflect timer
        execute function render:time/round_timer/name_clock:
                # Calculate minutes and seconds
                scoreboard objectives add var.seconds dummy
                scoreboard objectives add var.minutes dummy
                minutes = Scoreboard("var.minutes")
                seconds = Scoreboard("var.seconds")
                minutes["$var"] = timer["$time"] / 1200
                seconds["$var"] = (timer["$time"] / 20) - 60 * minutes["$var"]

            time_display = {
                "translate": "game.round_timer",
                "with": [
                    [
                    {
                        "score": {
                            "name": minutes["$var"].scoreholder,
                            "objective": minutes["$var"].objective
                        },
                        "color": "green",
                        "bold": true
                    },
                    {
                        "text": ":",
                        "color": "green",
                        "bold": false
                    },
                    {
                        "score": {
                            "name": seconds["$var"].scoreholder,
                            "objective": seconds["$var"].objective
                        },
                        "color": "green",
                        "bold": true
                    }
                    ]
                ]
            }

            # Display timer text
            execute if score $var var.seconds matches ..9:
                    time_display."with"[0].insert(2, {
                        "text": "0",
                        "color": "green",
                        "bold": true
                    })
                    bossbar set game:time/round_timer name time_display
                    del time_display."with"[0][2]
            execute if score $var var.seconds matches 10.. run bossbar set game:time/round_timer name time_display

            # Display timer text as yellow at 50%
            execute store result score $operand math.division run function util:get/base_timer
            scoreboard players set $operator math.division 2
            function util:math/division
                execute if score $time timer <= $result math.result expand:
                    for component in time_display."with"[0]:
                        component.color = "yellow"
                    execute if score $var var.seconds matches ..9:
                        time_display."with"[0].insert(2, {
                            "text": "0",
                            "color": "yellow",
                            "bold": true
                        })
                        bossbar set game:time/round_timer name time_display
                        del time_display."with"[0][2]
                    execute if score $var var.seconds matches 10.. run bossbar set game:time/round_timer name time_display

            # Display timer text as red at 25%
            scoreboard players operation $operand math.division = $result math.result
            scoreboard players set $operator math.division 2
            function util:math/division
                execute if score $time timer <= $result math.result expand:
                    for component in time_display."with"[0]:
                        component.color = "red"
                    execute if score $var var.seconds matches ..9:
                        time_display."with"[0].insert(2, {
                            "text": "0",
                            "color": "red",
                            "bold": true
                        })
                        bossbar set game:time/round_timer name time_display
                        del time_display."with"[0][2]
                    execute if score $var var.seconds matches 10.. run bossbar set game:time/round_timer name time_display
            
            # Clear unneeded variables
            scoreboard objectives remove var.minutes
            scoreboard objectives remove var.seconds
        # Change bossbar color as timer progresses
        execute function render:time/round_timer/bossbar_color:
            # Set bossbar to green by default
            bossbar set game:time/round_timer color green

            # Set bossbar to yellow at 50%
            execute store result score $operand math.division run function util:get/base_timer
            scoreboard players set $operator math.division 2
            function util:math/division
            execute if score $time timer <= $result math.result run bossbar set game:time/round_timer color yellow

            # Set bossbar to red at 25%
            scoreboard players operation $operand math.division = $result math.result
            scoreboard players set $operator math.division 2
            function util:math/division
            execute if score $time timer <= $result math.result run bossbar set game:time/round_timer color red
        
    # Play final warning as timer reaches zero
    execute if score $time timer matches ..200 function render:time/round_timer/final_warning:
        execute if score $time timer matches 200 tellraw @a[tag=playing,scores={game.player.team_id=1}] {"translate": "game.round_timer.runner_warning","color":"gray"}
        execute if score $time timer matches 200 tellraw @a[tag=playing,scores={game.player.team_id=2}] {"translate": "game.round_timer.killer_warning","color":"red"}
        for n in range(1, 21):
            execute if score $time timer matches (n*20) run expand:
                playsound minecraft:block.note_block.didgeridoo master @a[tag=playing] 0 0 0 1 (2-(n*0.01)) 1
                playsound minecraft:block.note_block.didgeridoo master @a[tag=playing] 0 0 0 1 (1-(n*0.01)) 1
        execute if score $var timerModulo matches 0 expand:
            playsound minecraft:block.note_block.bass master @a[tag=playing] 0 0 0 0.1 0.5 0.1
            playsound minecraft:block.note_block.bass master @a[tag=playing] 0 0 0 0.1 0.5 0.1
    scoreboard objectives remove timerModulo

execute function game:gameplay/tick/endgame_timer:
    timer = Scoreboard.objective("time.endgame_timer")
    # Increment timer
    execute if score $time timer matches 1.. run scoreboard players remove $time timer 1
    scoreboard objectives add var.timer_modulo dummy
    timerModulo = Scoreboard("var.timer_modulo")
    timerModulo["$var"] = timer["$time"] % 20

    execute if score $var timerModulo matches 0 store result bossbar game:time/endgame_timer value run scoreboard players get $time timer
    # End game if timer reaches zero
    execute if score $time timer matches 0 run return run function game:round/end

    execute function render:time/endgame_timer/display:
        # Update bossbar name to reflect timer
        execute function render:time/endgame_timer/name_clock:
                # Calculate minutes and seconds
                scoreboard objectives add var.seconds dummy
                scoreboard objectives add var.minutes dummy
                minutes = Scoreboard("var.minutes")
                seconds = Scoreboard("var.seconds")
                minutes["$var"] = timer["$time"] / 1200
                seconds["$var"] = (timer["$time"] / 20) - 60 * minutes["$var"]

            time_display = {
                "translate": "game.endgame_timer",
                "color": "gold",
                "with": [
                    [
                        {
                            "score": {
                                "name": minutes["$var"].scoreholder,
                                "objective": minutes["$var"].objective
                            },
                            "color": "red",
                            "bold": true
                        },
                        {
                            "text": ":",
                            "color": "red",
                            "bold": false
                        },
                        {
                            "score": {
                                "name": seconds["$var"].scoreholder,
                                "objective": seconds["$var"].objective
                            },
                            "color": "red",
                            "bold": true
                        }
                    ]
                ]
            }
            execute if score $var var.seconds matches 10.. run bossbar set game:time/endgame_timer name time_display
                execute if score $var var.seconds matches ..9:
                    time_display."with"[0].insert(2, {
                        "text": "0",
                        "color": "red",
                        "bold": true
                    })
                    bossbar set game:time/endgame_timer name time_display
            
                # Clear unneeded variables
                scoreboard objectives remove var.minutes
                scoreboard objectives remove var.seconds
        
    # Play final warning as timer reaches zero
    execute if score $time timer matches ..600 function render:time/endgame_timer/final_warning:
        execute if score $time timer matches 300 tellraw @a[tag=playing,scores={game.player.team_id=1}] {"translate": "game.round_timer.runner_warning","color":"gray"}
        execute if score $time timer matches 300 tellraw @a[tag=playing,scores={game.player.team_id=2}] {"translate": "game.round_timer.killer_warning","color":"red"}

        for n in range(1, 21):
            execute if score $time timer matches (n*20) run expand:
                playsound minecraft:block.note_block.didgeridoo master @a[tag=playing] 0 0 0 1 (2-(n*0.01)) 1
                playsound minecraft:block.note_block.didgeridoo master @a[tag=playing] 0 0 0 1 (1-(n*0.01)) 1
        execute if score $time timer matches ..200 if score $var timerModulo matches 0 expand:
            playsound minecraft:block.note_block.xylophone master @a[tag=playing] 0 0 0 0.1 0.5 0.1
            playsound minecraft:block.note_block.bass master @a[tag=playing] 0 0 0 0.1 0.5 0.1
    
        timerModulo["$var"] = timer["$time"] % 10
        execute if score $var timerModulo matches 0 if score $time timer matches ..400 as @a[tag=playing] at @s expand:
            particle minecraft:copper_fire_flame 0 0 0 10 10 10 0.1 50 normal @s
            particle minecraft:soul_fire_flame 0 0 0 10 10 10 0.1 50 normal @s
    
        for n in range(1, 7):
            execute if score $time timer matches (n*100) run playsound minecraft:block.bell.use master @a[tag=playing] 0 0 0 1 (1-(n*0.07)) 1
        timerModulo["$var"] = timer["$time"] % 100
        execute if score $var timerModulo matches 60 run playsound minecraft:block.bell.resonate master @a[tag=playing] 0 0 0 1 0.7 1
        execute if score $var timerModulo matches 0 as @a[tag=playing] at @s expand:
            particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~ ~ 10 10 10 0.1 30 normal
            particle minecraft:falling_dust{block_state:"minecraft:gold_block"} ~ ~ ~ 10 10 10 0.1 30 normal
            particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~ ~ 3 3 3 1 50 normal
            particle minecraft:falling_dust{block_state:"minecraft:gold_block"} ~ ~ ~ 3 3 3 1 50 normal
    scoreboard objectives remove var.timer_modulo