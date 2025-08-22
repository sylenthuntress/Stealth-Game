execute as @a run function render:tick/personal

execute function render:points/animate_sidebar:
    def makePointsText():
        pointsText = []
        for char in "Points":
            pointsText.append({
                "text": char,
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
    
    for n in range(12):
        sidebarText = makeSidebarText()
        pointsText = makePointsText()

        pointsText[int(n/2)].color = "white"
        if n > 1 and n < 11:
            pointsText[int(n/2)-1].color = "white"
        for i in range(6):
            sidebarText.insert(i + 2, pointsText[i])
        execute if score $time animations.sidebar.name matches (animDuration - (12 - n)) run scoreboard objectives modify game.player.points displayname sidebarText
    sidebarText = makeSidebarText()
    pointsText = makePointsText()
    for n in range(6):
        sidebarText.insert(n + 2, pointsText[n])
    execute if score $time animations.sidebar.name matches (0, animDuration - 12) run scoreboard objectives modify game.player.points displayname sidebarText