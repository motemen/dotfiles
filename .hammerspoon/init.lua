hs.hotkey.bind({"cmd","ctrl"}, "Y", function()
    -- hs.application.launchOrFocus("Google Chrome")
    local chrome = hs.appfinder.appFromName("Google Chrome")
    if chrome then
        chrome:activate()
    end
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
    hs.application.launchOrFocus("Firefox Developer Edition")
end)

hs.hotkey.bind({"cmd","ctrl"}, "U", function()
    -- hs.application.launchOrFocus("Visual Studio Code")
    local app = hs.appfinder.appFromName("Visual Studio Code")
    if app then
        app:activate()
    end
end)
