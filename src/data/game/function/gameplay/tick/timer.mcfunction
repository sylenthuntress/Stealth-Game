from bolt_expressions import Scoreboard, Data
timer = Scoreboard.objective("time.round_timer")

# Increment timer
scoreboard players remove $time time.round_timer 1
execute store result bossbar game:time/round_timer value run scoreboard players get $time time.round_timer

# Run appropriate logic based on timer
    # End game if timer reaches zero
    execute if score $time time.round_timer matches 0 run function game:round/end
    execute if score $time time.round_timer matches 0 run return fail

    # Update bossbar name to reflect timer
        # Calculate minutes and seconds
        scoreboard objectives add var.seconds dummy
        scoreboard objectives add var.minutes dummy
        minutes = Scoreboard("var.minutes")
        seconds = Scoreboard("var.seconds")
        minutes["$variable"] = timer["$time"] / 1200
        seconds["$variable"] = (timer["$time"] / 20) - 60 * minutes["$variable"]

    time_display = {
        "translate": "game.round_timer",
        "with": [
            {
                "score": {
                    "name": minutes["$variable"].scoreholder,
                    "objective": minutes["$variable"].objective
                }
            },
            ":",
            {
                "score": {
                    "name": seconds["$variable"].scoreholder,
                    "objective": seconds["$variable"].objective
                }
            }
        ]
    }
    execute if score $variable var.seconds matches 10.. run bossbar set game:time/round_timer name time_display
        execute if score $variable var.seconds matches ..9:
            time_display."with"[1] += "0"
            bossbar set game:time/round_timer name time_display
    
        # Clear unneeded variables
        scoreboard objectives remove var.minutes
        scoreboard objectives remove var.seconds

    # Change bossbar color as timer progresses
        # Set bossbar to green by default
        bossbar set game:time/round_timer color green

        # Set bossbar to yellow at 50%
        execute store result score $operand math.division run function util:get/base_timer
        scoreboard players set $operator math.division 2
        function util:math/division
        execute if score $time time.round_timer <= $result math.result run bossbar set game:time/round_timer color yellow

        # Set bossbar to red at 25%
        scoreboard players operation $operand math.division = $result math.result
        scoreboard players set $operator math.division 2
        function util:math/division
        execute if score $time time.round_timer <= $result math.result run bossbar set game:time/round_timer color red
    
    # Play final warning sounds as timer reaches zero
    execute if score $time time.round_timer matches 60 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5
    execute if score $time time.round_timer matches 40 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5
    execute if score $time time.round_timer matches 20 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5