from bolt_expressions import Scoreboard

# Showcase points as decimals
execute function render:points/format_sidebar:
    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$variable"] = points["@s"] / 10
    pointsDecimal["$variable"] = points["@s"] % 10

    scoreboard players display numberformat @s game.player.points fixed [
            {
                "score": {
                    "name": "$variable",
                    "objective": "var.points_whole"
                },
                "color": "red"
            },
            ".",
            {
                "score": {
                    "name": "$variable",
                    "objective": "var.points_decimal"
                },
                "color": "red"
            }
        ]
        # Remove unneeded variables
        scoreboard objectives remove var.points_decimal
        scoreboard objectives remove var.points_whole