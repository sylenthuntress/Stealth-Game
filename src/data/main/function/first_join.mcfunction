execute store result score @s uid.player run scoreboard players add #uid.index uid.index 1

tellraw @s {"translate":"main.new_join","color":"yellow","with": [{"selector":"@s","color":"gold"},{"translate":"main.game_name","color":"gold","bold":true}]}
function lobby:join_lobby

# PLAYTEST MODE
from menu:guidebook import DialogBuilder
from menu:builder import TextBuilder
dialog show @s (DialogBuilder("playtest")
    .translate_title("")
    .line(TextBuilder("menu.playtest.1")
        .translate("Hey, welcome to the playtest for \n%s %s.")
        .with_text(TextBuilder("main.game_name")
            .translated()
            .color("gold")
            .bold()
            .build())
        .with_text(TextBuilder("main.game_version")
            .translated()
            .color("gold")
            .build())
        .color("gray")
        .build())
    .line(TextBuilder("menu.playtest.2")
        .translate("All features currently present are experimental, and several features are currently missing. All content is subject to change, so please judge the gameplay and build-design with this in mind.")
        .color("gray")
        .build())
    .line(TextBuilder("menu.playtest.3")
        .translate("Please keep feedback constructive and open. While criticism will be accepted regardless of delivery, rude feedback will be demotivating and less convincing.")
        .color("gray")
        .build())
    .line(TextBuilder("menu.playtest.4")
        .translate("To see the (WIP) Guidebook, check below or run '/trigger menu.guidebook.selected_page'.\n\nEnjoy!")
        .color("gray")
        .bold()
        .build())
    .page("guidebook/intro")
    .build().get("dialog"))