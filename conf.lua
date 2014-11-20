-- set config options
function love.conf(t)
    t.identity = nil                   -- The name of the save directory (string)
    t.version = '0.9.1'                -- The LÖVE version this game was made for (string)
    t.window.title = 'gravity'         -- The window title (string)
    t.window.icon = nil                -- Filepath to an image to use as the window's icon (string)
    t.window.width = 1024              -- The window width (number)
    t.window.height = 768              -- The window height (number)
    t.window.borderless = false        -- Remove all border visuals from the window (boolean)
    t.window.resizable = false         -- Let the window be user-resizable (boolean)
    t.window.fullscreen = false        -- Enable fullscreen (boolean)
    t.window.fullscreentype = 'normal' -- Standard fullscreen or desktop fullscreen mode (string)
    t.window.vsync = true              -- Enable vertical sync (boolean)
    t.window.fsaa = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.display = 1               -- Index of the monitor to show the window in (number)
    t.window.highdpi = false           -- Enable high-dpi mode for the window on a Retina display (boolean).
    t.window.srgb = false              -- Enable sRGB gamma correction when drawing to the screen (boolean).
end
