hs.hotkey.bind({"cmd","ctrl"}, "Y", function()
    hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"cmd","ctrl"}, "L", function()
    local slack = hs.appfinder.appFromName("Slack")
    if slack then
        slack:activate()
    end
end)

hs.hotkey.bind({"cmd","ctrl"}, "I", function()
    hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd","ctrl"}, "H", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"cmd","ctrl"}, "U", function()
    hs.application.launchOrFocus("Visual Studio Code")
end)
