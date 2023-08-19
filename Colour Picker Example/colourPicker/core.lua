if not host:isHost() then return end
require('colourPicker.tables')
require('colourPicker.UIHandler')
require('colourPicker.colourHandler')
local loadedData = config:load('colourPicker')
if loadedData then
	selectedColour = loadedData
	lastColour = loadedData
else
	selectedColour = vec(0.73583,0.523,0.937)
	lastColour = vec(0.73583,0.523,0.937)
end

function colourPicker.onSubmit(colour)
	models.model.cube:setColor(colour)
end

function colourPicker.toggle(toggleValue)
  colourPicker.isEnabled = toggleValue
  models.colourPicker.GUI.HUD.colourPicker:setVisible(toggleValue)
  host:setUnlockCursor(toggleValue)
  client:isHudEnabled(not toggleValue)
end

colourPicker.updateColours()





