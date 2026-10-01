-- Personal keybindings from dotfiles/configs/hypr/hyprland.lua.
-- Keep all bindings in this module so the default set does not conflict.
local mainMod = "ALT"
local terminal = "kitty"
local fileManager = "dolphin"
local noctCall = "noctalia msg "

-- The current configuration documents an AZERTY number row. Use physical
-- keycodes for the five workspace shortcuts so they work without Shift.
local function digitCode(d)
    return "code:" .. (9 + d)
end

---------------------
---- SCREENSHOTS ----
---------------------

-- Select a window for a screenshot
hl.bind(
    mainMod .. " + PRINT",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-window.sh")
)

-- Screenshot current monitor
hl.bind(
    "PRINT",
    hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen")
)

-- Screenshot selected region
hl.bind(
    "SHIFT + PRINT",
    hl.dsp.exec_cmd(noctCall .. "screenshot-region")
)

-- Screenshot selected region
hl.bind(
    "SUPER + SHIFT + S",
    hl.dsp.exec_cmd(noctCall .. "screenshot-region")
)

---------------------
---- LOCK SCREEN ----
---------------------

hl.bind(
    "SUPER + L",
    hl.dsp.exec_cmd(noctCall .. "session lock")
)

----------------------
---- DISPLAY MODE ----
----------------------

-- Fn + F4 / display switch key
hl.bind(
    "XF86Display",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/switch-display.sh")
)

--------------------------
---- BRIGHTNESS KEYS ----
--------------------------

-- Fn + F3 / brightness up
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set +5%"),
    {
        repeating = true,
    }
)

-- Fn + F2 / brightness down
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 5%-"),
    {
        repeating = true,
    }
)

---------------------------
---- DEFAULT SHORTCUTS ----
---------------------------

-- ALT + ENTER
-- Open normal terminal
hl.bind(
    mainMod .. " + Return",
    hl.dsp.exec_cmd(terminal)
)

--------------------------------------------
---- TERMINAL IN THE CURRENT DIRECTORY ----
--------------------------------------------

-- ALT + SHIFT + ENTER is handled by Kitty:
-- map alt+shift+enter launch --type=os-window --cwd=current

----------------------
---- CLOSE WINDOW ----
----------------------

-- ALT + Q
hl.bind(
    mainMod .. " + Q",
    hl.dsp.window.close()
)

---------------------
---- EXIT HYPRLAND ----
---------------------

-- ALT + M
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd(noctCall .. "session logout")
)

-----------------------
---- FILE MANAGER ----
-----------------------

-- ALT + R
hl.bind(
    mainMod .. " + R",
    hl.dsp.exec_cmd(fileManager)
)

-------------------------
---- TOGGLE FLOATING ----
-------------------------

-- ALT + V
hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({
        action = "toggle",
    })
)

------------------------
---- APPLICATION MENU ----
------------------------

-- ALT + F
hl.bind(
    mainMod .. " + F",
    hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher")
)

--------------------
---- MOVE FOCUS ----
--------------------

-- ALT + LEFT
hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({
        direction = "left",
    })
)

-- ALT + RIGHT
hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({
        direction = "right",
    })
)

-- ALT + UP
hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({
        direction = "up",
    })
)

-- ALT + DOWN
hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({
        direction = "down",
    })
)

----------------------
---- MOVE WINDOWS ----
----------------------

-- ALT + SHIFT + LEFT
hl.bind(
    mainMod .. " + SHIFT + left",
    hl.dsp.window.move({
        direction = "left",
    })
)

-- ALT + SHIFT + RIGHT
hl.bind(
    mainMod .. " + SHIFT + right",
    hl.dsp.window.move({
        direction = "right",
    })
)

-- ALT + SHIFT + UP
hl.bind(
    mainMod .. " + SHIFT + up",
    hl.dsp.window.move({
        direction = "up",
    })
)

-- ALT + SHIFT + DOWN
hl.bind(
    mainMod .. " + SHIFT + down",
    hl.dsp.window.move({
        direction = "down",
    })
)

------------------------
---- RESIZE WINDOWS ----
------------------------

-- ALT + CTRL + LEFT
hl.bind(
    mainMod .. " + CTRL + left",
    hl.dsp.window.resize({
        x = -40,
        y = 0,
        relative = true,
    }),
    {
        repeating = true,
    }
)

-- ALT + CTRL + RIGHT
hl.bind(
    mainMod .. " + CTRL + right",
    hl.dsp.window.resize({
        x = 40,
        y = 0,
        relative = true,
    }),
    {
        repeating = true,
    }
)

-- ALT + CTRL + UP
hl.bind(
    mainMod .. " + CTRL + up",
    hl.dsp.window.resize({
        x = 0,
        y = -40,
        relative = true,
    }),
    {
        repeating = true,
    }
)

-- ALT + CTRL + DOWN
hl.bind(
    mainMod .. " + CTRL + down",
    hl.dsp.window.resize({
        x = 0,
        y = 40,
        relative = true,
    }),
    {
        repeating = true,
    }
)

-----------------------
---- WINDOW GROUPS ----
-----------------------

-- SUPER + G
-- Toggle window group
hl.bind(
    "SUPER + G",
    hl.dsp.group.toggle()
)

-- SUPER + RIGHT
-- Next window in group
hl.bind(
    "SUPER + right",
    hl.dsp.group.next()
)

-- SUPER + LEFT
-- Previous window in group
hl.bind(
    "SUPER + left",
    hl.dsp.group.prev()
)

------------------------
---- WINDOW SWITCHER ----
------------------------

-- ALT + TAB
hl.bind(
    mainMod .. " + TAB",
    hl.dsp.exec_cmd(noctCall .. "window-switcher")
)

-- ALT + SHIFT + TAB
hl.bind(
    mainMod .. " + SHIFT + TAB",
    hl.dsp.exec_cmd(noctCall .. "window-switcher")
)

---------------------------------
---- LAYOUT / SPLIT CONTROLS ----
---------------------------------

-- ALT + T
hl.bind(
    mainMod .. " + T",
    hl.dsp.layout("swapwithmaster")
)

--------------------
---- FULLSCREEN ----
--------------------

-- SUPER + SPACE
-- Maximized mode
hl.bind(
    "SUPER + SPACE",
    hl.dsp.window.fullscreen({
        mode = "maximized",
        action = "toggle",
    })
)

--------------------
---- PSEUDOTILE ----
--------------------

-- ALT + P
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo({
        action = "toggle",
    })
)

-----------------------
---- TRUE FULLSCREEN ----
-----------------------

-- SUPER + SHIFT + SPACE
hl.bind(
    "SUPER + SHIFT + SPACE",
    hl.dsp.window.fullscreen({
        mode = "fullscreen",
        action = "toggle",
    })
)

-------------------
---- WALLPAPERS ----
-------------------

-- SUPER + SHIFT + W: cycle through ~/Pictures/wallpapers
hl.bind(
    "SUPER + SHIFT + W",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/next-wallpaper.sh")
)

----------------------------------------------
---- MINIMIZE USING A SPECIAL WORKSPACE ----
----------------------------------------------

-- ALT + N
-- Send focused window to special workspace
hl.bind(
    mainMod .. " + N",
    hl.dsp.window.move({
        workspace = "special:special",
        follow = false,
    })
)

-- ALT + SHIFT + N
-- Show/hide special workspace
hl.bind(
    mainMod .. " + SHIFT + N",
    hl.dsp.workspace.toggle_special("special")
)

---------------------
---- WORKSPACES ----
---------------------

-- SUPER + 1 through SUPER + 5
-- Switch workspace
for workspace = 1, 5 do
    hl.bind(
        "SUPER + " .. digitCode(workspace),
        hl.dsp.focus({
            workspace = workspace,
        })
    )
end

--------------------------------
---- MOVE TO WORKSPACE ----
--------------------------------

-- SUPER + SHIFT + 1 through 5
-- Move window and follow it
for workspace = 1, 5 do
    hl.bind(
        "SUPER + SHIFT + " .. digitCode(workspace),
        hl.dsp.window.move({
            workspace = workspace,
            follow = true,
        })
    )
end
