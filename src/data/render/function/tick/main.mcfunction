execute as @a run function render:tick/personal

# Animates the sidebar
execute function render:points/animate_sidebar:
    def makePointsText():
        pointsText = []
        for char in "Round ":
            pointsText.append({
                "text": char,
                "color": "gold",
                "bold": false
            })
        pointsText.append({
            "score": {
                "name": "$gamestate",
                "objective": "gamestate.round_count"
            },
            "color": "gold",
            "bold": false
        })
        pointsText.append({
            "text": "/",
            "color": "gold",
            "bold": false
        })
        pointsText.append({
            "score": {
                "name": "$gamestate",
                "objective": "gamestate.round_total"
            },
            "color": "gold",
            "bold": false
        })
        return pointsText
    def makeSidebarText():
        return [
            {
                "text": "===",
                "color": "red",
                "bold": true
            },
            " ",
            " ",
            {
                "text": "===",
                "color": "red",
                "bold": true
            }
        ]
        
    animDuration = 202
    scoreboard players add $time animations.sidebar.name 1
    execute if score $time animations.sidebar.name matches (animDuration, None) run scoreboard players set $time animations.sidebar.name 0
    pointsText = makePointsText()
    pointsTextLength = pointsText.__len__()
    for n in range(pointsTextLength * 2):
        pointsText = makePointsText()
        pointsTextLength = pointsText.__len__()
        sidebarText = makeSidebarText()
        pointsText[int(n/2)].color = "white"
        if n > 1 and n < pointsTextLength - 1:
            pointsText[int(n/2)-1].color = "white"
        for i in range(pointsText.__len__()):
            sidebarText.insert(i + 2, pointsText[i])
        execute if score $time animations.sidebar.name matches (animDuration - ((pointsTextLength * 2) - n)) run scoreboard objectives modify game.player.points displayname sidebarText
    sidebarText = makeSidebarText()
    pointsText = makePointsText()
    for n in range(pointsTextLength):
        sidebarText.insert(n + 2, pointsText[n])
    execute if score $time animations.sidebar.name matches (0, animDuration - (pointsTextLength * 2)) run scoreboard objectives modify game.player.points displayname sidebarText