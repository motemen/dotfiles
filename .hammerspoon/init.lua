hs.hotkey.bind({"cmd","ctrl"}, "Y", function()
    -- hs.application.launchOrFocus("Google Chrome")
    local chrome = hs.appfinder.appFromName("Google Chrome")
    -- local chrome = hs.appfinder.appFromName("Opera")
    if chrome then
        chrome:activate()
    end
end)

hs.hotkey.bind({"cmd","ctrl"}, "L", function()
    local slack = hs.appfinder.appFromName("Slack")
    -- local slack = hs.appfinder.appFromName("Discord")
    if slack then
        slack:activate()
    end
end)

hs.hotkey.bind({"cmd","ctrl"}, "I", function()
    -- hs.application.launchOrFocus("iTerm")
    local app = hs.application.find("iTerm")
    if app then
        app:activate()
    end
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

hs.hotkey.bind({"cmd","ctrl"}, "P", function()
    -- hs.application.launchOrFocus("Visual Studio Code")
    local app = hs.appfinder.appFromName("TickTick")
    if app then
        app:activate()
    end
end)
