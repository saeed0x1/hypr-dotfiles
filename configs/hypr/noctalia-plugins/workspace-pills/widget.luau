local number = tonumber(noctalia.getConfig("number"))
local waiting = false
local active = nil

local function show(isActive)
    if active == isActive then
        return
    end
    active = isActive
    barWidget.render(ui.row({
        width = 36,
        height = 30,
        align = "center",
        justify = "center",
    }, {
        ui.row({
            width = 36,
            height = 30,
            fill = isActive and "#89b4fa" or "#1e1e2e",
            radius = 12,
            align = "center",
            justify = "center",
            onClick = "switchWorkspace",
        }, {
            ui.label({
                text = tostring(number),
                fontSize = 16,
                fontWeight = "bold",
                color = isActive and "#1e1e2e" or "#cdd6f4",
            }),
        }),
    }))
end

function switchWorkspace()
    -- Update every button before the next compositor poll.
    noctalia.state.set("active_workspace", number)
    noctalia.runAsync({ "hyprctl", "dispatch", "hl.dsp.focus({ workspace = " .. number .. " })" }, function(result)
        if result.exitCode ~= 0 then
            update()
        end
    end)
end

noctalia.state.watch("active_workspace", function(value)
    show(tonumber(value) == number)
end)
show(tonumber(noctalia.state.get("active_workspace")) == number)
if number == 1 then
    noctalia.setUpdateInterval(500)
end

function update()
    if waiting then
        return
    end

    waiting = true
    local accepted = noctalia.runAsync({ "hyprctl", "activeworkspace", "-j" }, function(result)
        waiting = false
        if result.exitCode ~= 0 then
            return
        end

        local workspace = noctalia.json.decode(result.stdout)
        local workspaceNumber = workspace and tonumber(workspace.id)
        if workspaceNumber then
            noctalia.state.set("active_workspace", workspaceNumber)
        end
    end)

    if not accepted then
        waiting = false
    end
end

if number == 1 then
    update()
end
