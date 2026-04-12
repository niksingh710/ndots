{ pkgs, ... }:
{
  home.packages = with pkgs; [ hammerspoon ];

  home.file.".hammerspoon/init.lua".text = # lua
    ''
      local VimMode = hs.loadSpoon('VimMode')
      local vim = VimMode:new()

      vim:shouldDimScreenInNormalMode(false)
      vim:disableForApp('Code')
      vim:disableForApp('MacVim')
      vim:disableForApp('zoom.us')
      vim:disableForApp('kitty')
      vim:disableForApp('Maccy')
      vim:enterWithSequence('jk')
      vim:enableBetaFeature('block_cursor_overlay')
      vim:shouldShowAlertInNormalMode(true)

      -- Exit normal mode with 'q'
      vim.modal:bind({}, 'q', function()
        vim:exitAsync()
      end)

      -- Exit normal mode with 'Escape'
      vim.modal:bind({}, 'escape', function()
        vim:exitAsync()
      end)

      -- Custom glass-style indicator for Normal/Visual mode
      hs.timer.doAfter(2.0, function()
        local canvas = vim.stateIndicator.canvas
        if not canvas then return end

        -- Static position at bottom center of focused window
        local function getStaticPosition()
          local win = hs.window.focusedWindow()
          if win then
            local frame = win:frame()
            print("Window frame: x=" .. frame.x .. " y=" .. frame.y .. " w=" .. frame.w .. " h=" .. frame.h)
            local pos = {
              x = math.floor(frame.x + (frame.w / 2) - 20),
              y = math.floor(frame.y + frame.h - 38)
            }
            print("Static position from window: x=" .. pos.x .. " y=" .. pos.y)
            return pos
          end

          local screen = hs.mouse.getCurrentScreen() or hs.screen.mainScreen()
          if screen then
            local frame = screen:fullFrame()
            print("Screen frame fallback")
            return {
              x = math.floor(frame.x + (frame.w / 2) - 20),
              y = math.floor(frame.y + frame.h - 68)
            }
          end

          print("Using hardcoded position")
          return { x = 500, y = 800 }
        end

        -- Get position near cursor if in text field
        local function getCursorPosition()
          local ax = require("hs.axuielement")
          local systemElement = ax.systemWideElement()
          if not systemElement then
            print("No system element")
            return nil
          end

          local currentElement = systemElement:attributeValue("AXFocusedUIElement")
          if not currentElement then
            print("No focused element")
            return nil
          end

          local role = currentElement:attributeValue("AXRole")
          print("Element role: " .. tostring(role))

          -- Strict text field detection
          local textRoles = {
            ["AXTextField"] = true,
            ["AXTextArea"] = true,
            ["AXComboBox"] = true,
            ["AXSearchField"] = true
          }

          if not textRoles[role] then
            print("Not a text field, role is: " .. tostring(role))
            return nil
          end

          local position = currentElement:attributeValue('AXPosition')
          if not position then
            print("No position attribute")
            return nil
          end

          -- Validate position is reasonable (positive coordinates, on screen)
          if position.x < 0 or position.y < 0 then
            print("Invalid position: x=" .. position.x .. " y=" .. position.y)
            return nil
          end

          print("Valid cursor position: x=" .. position.x .. " y=" .. position.y)
          return {
            x = position.x + 3,
            y = position.y - 31
          }
        end

        -- Replace render function
        vim.stateIndicator.render = function(self)
          print("RENDER CALLED - mode: " .. vim.mode .. " enabled: " .. tostring(vim.enabled))

          if not vim.config.shouldShowAlertInNormalMode then
            print("Alert disabled in config")
            return false
          end

          local mode = vim.mode
          if mode ~= 'normal' and mode ~= 'visual' then
            print("Not in normal/visual, hiding")
            canvas:hide()
            return false
          end

          print("Should show indicator...")

          -- Choose position
          local pos
          local cursorPos = getCursorPosition()
          if cursorPos and cursorPos.x and cursorPos.x > 0 then
            pos = cursorPos
            print("Using CURSOR position")
          else
            pos = getStaticPosition()
            print("Using STATIC position")
          end
          print("Setting canvas position to: x=" .. pos.x .. " y=" .. pos.y)
          canvas:topLeft(pos)
          canvas:level("overlay")

          canvas:elementAttribute(1, 'fillColor', {
            red = 0.12, green = 0.12, blue = 0.12, alpha = 0.9
          })
          canvas:elementAttribute(1, 'strokeColor', { white = 1.0, alpha = 0.4 })
          canvas:elementAttribute(1, 'strokeWidth', 1.0)
          canvas:elementAttribute(1, 'roundedRectRadii', { xRadius = 8, yRadius = 8 })

          canvas:size({ w = 40, h = 28 })

          local text = (mode == 'visual') and "V" or "N"
          canvas:elementAttribute(2, 'text', hs.styledtext.new(text, {
            font = { size = 16 },
            color = { white = 1.0 },
            paragraphStyle = { alignment = 'center' }
          }))

          canvas:show()
          return true
        end
      end)

      -- ============================================
      -- HAMMERSPOON MODE (Ctrl+Option+Shift+H)
      -- ============================================
      local hsmode = {}
      hsmode.active = false
      hsmode.canvas = nil
      hsmode.timers = {}

      function hsmode.keyboardBrightness(direction)
        local event = require("hs.eventtap").event
        local key = (direction == "up") and "ILLUMINATION_UP" or "ILLUMINATION_DOWN"
        event.newSystemKeyEvent(key, true):post()
        hs.timer.usleep(10000)
        event.newSystemKeyEvent(key, false):post()
      end

      function hsmode.startBrightnessRepeat(direction)
        hsmode.stopBrightnessRepeat()
        hsmode.keyboardBrightness(direction)
        hsmode.timers[direction] = hs.timer.doEvery(0.1, function()
          hsmode.keyboardBrightness(direction)
        end)
      end

      function hsmode.stopBrightnessRepeat()
        for _, timer in pairs(hsmode.timers) do
          if timer then timer:stop() end
        end
        hsmode.timers = {}
      end

      function hsmode.createIndicator()
        local canvas = hs.canvas.new { w = 40, h = 28, x = 100, y = 100 }

        canvas:insertElement({
          type = 'rectangle',
          action = 'fill',
          roundedRectRadii = { xRadius = 8, yRadius = 8 },
          fillColor = { red = 0.2, green = 0.2, blue = 0.2, alpha = 0.85 },
          strokeColor = { white = 1.0, alpha = 0.4 },
          strokeWidth = 1.0,
          frame = { x = 0, y = 0, h = 28, w = 40 },
          withShadow = true
        })

        canvas:insertElement({
          type = 'text',
          action = 'fill',
          frame = { x = 4, y = 4, h = 20, w = 32 },
          text = hs.styledtext.new("🔨", {
            font = { size = 16 },
            color = { white = 1.0 },
            paragraphStyle = { alignment = 'center' }
          })
        })

        return canvas
      end

      function hsmode.showIndicator()
        if not hsmode.canvas then
          hsmode.canvas = hsmode.createIndicator()
        end

        local screen = hs.screen.mainScreen()
        local frame = screen:frame()
        hsmode.canvas:topLeft({
          x = frame.x + (frame.w / 2) - 20,
          y = frame.y + frame.h - 40
        })
        hsmode.canvas:level("overlay")
        hsmode.canvas:show()
      end

      function hsmode.hideIndicator()
        if hsmode.canvas then
          hsmode.canvas:hide()
        end
      end

      hsmode.bindings = {}

      function hsmode.enter()
        hsmode.active = true
        hsmode.showIndicator()

        hsmode.bindings['comma'] = hs.hotkey.bind({ "shift" }, 43, function()
          hsmode.startBrightnessRepeat("down")
        end, function()
          hsmode.stopBrightnessRepeat()
        end)

        hsmode.bindings['period'] = hs.hotkey.bind({ "shift" }, 47, function()
          hsmode.startBrightnessRepeat("up")
        end, function()
          hsmode.stopBrightnessRepeat()
        end)

        hsmode.bindings['r'] = hs.hotkey.bind({}, "r", function()
          hs.reload()
          hsmode.exit()
        end)

        hsmode.bindings['q'] = hs.hotkey.bind({}, "q", function()
          hsmode.exit()
        end)

        hsmode.bindings['escape'] = hs.hotkey.bind({}, "escape", function()
          hsmode.exit()
        end)

        hs.alert.show("Hammerspoon Mode", 0.5)
      end

      function hsmode.exit()
        hsmode.active = false
        hsmode.hideIndicator()

        for _, binding in pairs(hsmode.bindings) do
          binding:delete()
        end
        hsmode.bindings = {}
      end

      hs.hotkey.bind({ "ctrl", "option", "shift" }, "H", function()
        if not hsmode.active then
          hsmode.enter()
        end
      end)
    '';

  home.file.".hammerspoon/Spoons/VimMode.spoon".source = pkgs.fetchgit {
    url = "https://github.com/dbalatero/VimMode.spoon.git";
    rev = "a428e1ae9cc5d937fa6d148da6e2a779c7594abd";
    sha256 = "1xpjkbcz2qq0ga3d7pjzhvqjf376fj66aasy1pp4q5s3qnj8718b";
  };
}
