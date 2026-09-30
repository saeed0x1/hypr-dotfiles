-- Match the two frames and one-second interval in dotfiles/configs/waybar/scripts/cat.sh.
local frames = { "ฅ^•ﻌ•^ฅ", "ฅ^•ω•^ฅ" }
local frame = 1

local function showFrame()
    barWidget.render(ui.row({
        height = 30,
        paddingH = 10,
        fill = "#1e1e2e",
        radius = 12,
        align = "center",
        justify = "center",
    }, {
        ui.label({ text = frames[frame], color = "#f9e2af" }),
    }))
end

showFrame()
noctalia.setUpdateInterval(1000)

function update()
    frame = frame % #frames + 1
    showFrame()
end
