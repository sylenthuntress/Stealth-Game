# Increment timer
scoreboard players remove #TIME time.round_timer 1
execute store result bossbar game:time/round_timer value run scoreboard players get #TIME time.round_timer

# Run appropriate logic based on timer
    # End game if timer reaches zero
    execute if score #TIME time.round_timer matches 0 run function game:round/end
    execute if score #TIME time.round_timer matches 0 run return fail

    # Update bossbar name to reflect timer
    bossbar set game:time/round_timer name {
        "translate": "game.round_timer",
        "with": [
            {
                "score": {
                    "name": "#TIME",
                    "objective": "time.round_timer"
                }
            }
        ]
    }

    # Change bossbar color as timer progresses
        # Set bossbar to green by default
        bossbar set game:time/round_timer color green

        # Set bossbar to yellow at 50%
        execute store result score #OPERAND math.division run function util:get/base_timer
        scoreboard players set #OPERATOR math.division 2
        function util:math/division
        execute if score #TIME time.round_timer <= #RESULT math.result run bossbar set game:time/round_timer color yellow

        # Set bossbar to red at 25%
        scoreboard players operation #OPERAND math.division = #RESULT math.result
        scoreboard players set #OPERATOR math.division 2
        function util:math/division
        execute if score #TIME time.round_timer <= #RESULT math.result run bossbar set game:time/round_timer color red
    
    # Play final warning sounds as timer reaches zero
    execute if score #TIME time.round_timer matches 60 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5
    execute if score #TIME time.round_timer matches 40 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5
    execute if score #TIME time.round_timer matches 20 as @a if function util:test/is_playing run playsound entity.arrow.hit master @s ~ ~ ~ 2 0.5