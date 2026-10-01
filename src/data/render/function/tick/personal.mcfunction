from bolt_expressions import Scoreboard

# Showcase points as decimals
execute function render:points/format_sidebar:
    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$var"] = points["@s"] / 10
    pointsDecimal["$var"] = points["@s"] % 10

    execute unless score $var pointsDecimal matches 0 run scoreboard players display numberformat @s game.player.points fixed [
            {
                "score": {
                    "name": "$var",
                    "objective": "var.points_whole"
                },
                "color": "red"
            },
            ".",
            {
                "score": {
                    "name": "$var",
                    "objective": "var.points_decimal"
                },
                "color": "red"
            }
        ]
    execute if score $var pointsDecimal matches 0 run scoreboard players display numberformat @s game.player.points fixed [
            {
                "score": {
                    "name": "$var",
                    "objective": "var.points_whole"
                },
                "color": "red"
            }
        ]
    # Remove unneeded variables
    scoreboard objectives remove var.points_decimal
    scoreboard objectives remove var.points_whole