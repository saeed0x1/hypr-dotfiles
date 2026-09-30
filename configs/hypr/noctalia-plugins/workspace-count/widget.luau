-- Hyprland reports the count of windows on the focused workspace directly.
local waiting = false

local function showCount(value)
    barWidget.render(ui.row({
        width = 36,
        height = 30,
        fill = "#1e1e2e",
        radius = 12,
        align = "center",
        justify = "center",
    }, {
        ui.label({
            text = value,
            fontSize = 16,
            fontWeight = "bold",
            color = "#89b4fa",
        }),
    }))
end

showCount("…")
noctalia.setUpdateInterval(1000)

function update()
    if waiting then
        return
    end

    waiting = true
    local accepted = noctalia.runAsync({ "hyprctl", "activeworkspace", "-j" }, function(result)
        waiting = false

        if result.exitCode ~= 0 then
            showCount("–")
            return
        end

        local workspace = noctalia.json.decode(result.stdout)
        local count = workspace and tonumber(workspace.windows)
        if count == nil then
            showCount("–")
            return
        end

        showCount(tostring(count))
    end)

    if not accepted then
        waiting = false
        showCount("–")
    end
end
