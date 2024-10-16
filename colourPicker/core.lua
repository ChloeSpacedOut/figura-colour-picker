if not host:isHost() then return end
require('colourPicker.tables')
require('colourPicker.UIHandler')
require('colourPicker.colourHandler')
local loadedData = config:load('colourPicker')
if loadedData and type(loadedData) == 'Vector3' then
	selectedColour = loadedData
	lastColour = loadedData:copy()
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
	if toggleValue then
		renderer:setCrosshairOffset(9999,0)
	else
		renderer:setCrosshairOffset(0,0)
	end
end

colourPicker.updateColours()