
local mash = {
  split   = {"ctrl", "alt", "cmd"},
  corner  = {"ctrl", "alt", "shift"},
  focus   = {"ctrl", "alt"},
  utils   = {"ctrl", "alt", "cmd"},
  hyper   = {"ctrl", "alt", "cmd", "shift" }
}

-- hs.window.animationDuration = 0


-- Focus windows
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then return end

    win[fn]()
  end
end

-- Resize windows
local function adjust(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end

    local f = win:frame()
    local max = win:screen():frame()

    f.w = math.floor(max.w * w)
    f.h = math.floor(max.h * h)
    f.x = math.floor((max.w * x) + max.x)
    f.y = math.floor((max.h * y) + max.y)

    win:setFrame(f)
  end
end

local function adjustCenterTop(w, h)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end

    local f = win:frame()
    local max = win:screen():frame()

    f.w = math.floor(max.w * w)
    f.h = math.floor(max.h * h)
    f.x = math.floor((max.w / 2) - (f.w / 2))
    f.y = max.y
    win:setFrame(f)
  end
end

local function stoken()
    os.execute("~/bin/rsa")
    hs.alert.show("Token pasted")
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end

-- top half
hs.hotkey.bind(mash.hyper, "t", adjust(0, 0, 1, 0.5))

-- right half
hs.hotkey.bind(mash.hyper, "r", adjust(0.5, 0, 0.5, 1))

-- bottom half
hs.hotkey.bind(mash.hyper, "d", adjust(0, 0.5, 1, 0.5))

-- left half
hs.hotkey.bind(mash.hyper, "l", adjust(0, 0, 0.5, 1))

-- top left
hs.hotkey.bind(mash.hyper, "1", adjust(0, 0, 0.5, 0.5))

-- top right
hs.hotkey.bind(mash.hyper, "2", adjust(0.5, 0, 0.5, 0.5))

-- bottom left
hs.hotkey.bind(mash.hyper, "3", adjust(0, 0.5, 0.5, 0.5))

-- bottom right
hs.hotkey.bind(mash.hyper, "4", adjust(0.5, 0.5, 0.5, 0.5))

-- fullscreen
hs.hotkey.bind(mash.hyper, "f", adjustCenterTop(1, 1))

-- stoken
hs.hotkey.bind(mash.hyper, "m", stoken)

-- config reload
hs.hotkey.bind(mash.hyper, "0", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- window hints
hs.hotkey.bind(mash.hyper, "e", hs.hints.windowHints)

-- application specific shortcuts
apps = {
    i = 'iTerm',
    b = 'Google Chrome',
    v = 'VidyoDesktop'
}

for key, app in pairs(apps) do
    hs.hotkey.bind(mash.hyper, key, function() hs.application.launchOrFocus(app) end)
end


-- grid
hs.grid.MARGINX     = 0
hs.grid.MARGINY     = 0
hs.grid.GRIDWIDTH   = 7
hs.grid.GRIDHEIGHT  = 3

hs.hotkey.bind(mash.focus, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash.focus, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(mash.focus, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(mash.focus, 'L', hs.grid.pushWindowRight)

-- resize windows
hs.hotkey.bind(mash.focus, 'Y', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash.focus, 'U', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash.focus, 'I', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash.focus, 'O', hs.grid.resizeWindowWider)

-- global operations
hs.hotkey.bind(mash.focus, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash.focus, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)


-- multi monitor
hs.hotkey.bind(mash.hyper, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash.hyper, 'P', hs.grid.pushWindowPrevScreen)

-- microphone
hs.hotkey.bind(mash.hyper, '\\', function()
    hs.applescript.applescript([[
    set inputVolume to input volume of (get volume settings)
    if inputVolume = 0 then
        set inputVolume to 100
        set displayNotification to "Microphone Unmuted"
    else
        set inputVolume to 0
        set displayNotification to "Microphone muted"
    end if
    set volume input volume inputVolume
    display notification displayNotification
    delay 1
    return
    ]])

end
)
