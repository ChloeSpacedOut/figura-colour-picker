if not host:isHost() then return end
require('colourPicker.tables')
colourPicker.textFields = {}
local coloursTexture = textures['colourPicker.textures.colours']

local colourPickerPath = models.colourPicker.GUI.HUD.colourPicker
local highlightsPath = colourPickerPath.highlights
colourPicker.textFields.red = highlightsPath.red:newText('red'):setAlignment("RIGHT"):pos(-13,0,-10)
colourPicker.textFields.green = highlightsPath.green:newText('green'):setAlignment("RIGHT"):pos(-13,0,-10)
colourPicker.textFields.blue = highlightsPath.blue:newText('blue'):setAlignment("RIGHT"):pos(-13,0,-10)

colourPicker.textFields.hue = highlightsPath.hue:newText('hue'):setAlignment("RIGHT"):pos(-13,0,-10)
colourPicker.textFields.saturation = highlightsPath.saturation:newText('saturation'):setAlignment("RIGHT"):pos(-13,0,-10)
colourPicker.textFields.vibrance = highlightsPath.vibrance:newText('vibrance'):setAlignment("RIGHT"):pos(-13,0,-10)

colourPicker.textFields.hex = highlightsPath.hex:newText('hex'):setAlignment("CENTER"):pos(0,0,-10)
colourPicker.textFields.save = highlightsPath.save:newText('save'):setAlignment("CENTER"):pos(0,0,-10):setText('OK')

for _, v in pairs{
	colourPickerPath.textures.selectorSliderColour,
	colourPickerPath.textures.hueSideSliderColour,
	colourPickerPath.textures.redSliderColour,
	colourPickerPath.textures.greenSliderColour,
	colourPickerPath.textures.blueSliderColour,
	colourPickerPath.textures.hueSliderColour,
	colourPickerPath.textures.saturationSliderColour,
	colourPickerPath.textures.vibranceSliderColour,
} do
	v:primaryRenderType('blurry')
end

notification = models.colourPicker.GUI.HUD.colourPicker.textures.notification:newText('notification'):setAlignment("CENTER")

function colourPicker.updateColours()
	local selectedColourRGB = vectors.hsvToRGB(selectedColour)

	-- for k = 0, 31 do
	-- 	textures['colourPicker.textures.redSliderColour']:setPixel(k,0,k/31,selectedColourRGB.y,selectedColourRGB.z)
	-- 	textures['colourPicker.textures.greenSliderColour']:setPixel(k,0,selectedColourRGB.x,k/31,selectedColourRGB.z)
	-- 	textures['colourPicker.textures.blueSliderColour']:setPixel(k,0,selectedColourRGB.x,selectedColourRGB.y,k/31)

	-- 	textures['colourPicker.textures.hueSliderColour']:setPixel(k,0,vectors.hsvToRGB(k/31,selectedColour.y,selectedColour.z))
	-- 	textures['colourPicker.textures.saturationSliderColour']:setPixel(k,0,vectors.hsvToRGB(selectedColour.x,k/31,selectedColour.z))
	-- 	textures['colourPicker.textures.vibranceSliderColour']:setPixel(k,0,vectors.hsvToRGB(selectedColour.x,selectedColour.y,k/31))
	-- end

	coloursTexture:setPixel(6, 0, 0, selectedColourRGB.g, selectedColourRGB.b)
	coloursTexture:setPixel(7, 0, 1, selectedColourRGB.g, selectedColourRGB.b)
	coloursTexture:setPixel(6, 1, selectedColourRGB.r, 0, selectedColourRGB.b)
	coloursTexture:setPixel(7, 1, selectedColourRGB.r, 1, selectedColourRGB.b)
	coloursTexture:setPixel(6, 2, selectedColourRGB.r, selectedColourRGB.g, 0)
	coloursTexture:setPixel(7, 2, selectedColourRGB.r, selectedColourRGB.g, 1)

	coloursTexture:setPixel(3, 3, vectors.hsvToRGB(selectedColour.x, 0, selectedColour.z))
	coloursTexture:setPixel(4, 3, vectors.hsvToRGB(selectedColour.x, 1, selectedColour.z))

	coloursTexture:setPixel(4, 4, vectors.hsvToRGB(selectedColour.x, selectedColourRGB.y, 1))

	for i = 0, 6 do
		coloursTexture:setPixel(1, i, vectors.hsvToRGB(i / 6, selectedColour.y, selectedColour.z))
	end

	coloursTexture:setPixel(4, 0, vectors.hsvToRGB(selectedColour.x, 1, 1))

	coloursTexture:setPixel(7, 7, selectedColourRGB)
	coloursTexture:setPixel(6, 7, vectors.hsvToRGB(lastColour))

	coloursTexture:update()

	for k,v in pairs(colourPicker.colorFeildMetadata) do
		if v.type == 'rgb' then
			colourPicker.textFields[k]:setText(math.floor(selectedColourRGB[v.axis]*v.max*10)/10)
		elseif v.type == 'hsv' then
			colourPicker.textFields[k]:setText(math.floor(selectedColour[v.axis]*v.max*10)/10)
		else
			colourPicker.textFields[k]:setText('#'..vectors.rgbToHex(selectedColourRGB))
		end
	end
	local sliderPath = models.colourPicker.GUI.HUD.colourPicker.sliders
	sliderPath.redSliderX:setPos((-selectedColourRGB.x*66),0,0)
	sliderPath.greenSliderX:setPos((-selectedColourRGB.y*66),0,0)
	sliderPath.blueSliderX:setPos((-selectedColourRGB.z*66),0,0)

	sliderPath.hueSliderX:setPos((-selectedColour.x*66),0,0)
	sliderPath.saturationSliderX:setPos((-selectedColour.y*66),0,0)
	sliderPath.vibranceSliderX:setPos((-selectedColour.z*66),0,0)

	sliderPath.hueSideSliderY:setPos(0,(selectedColour.x*218-218),0)

	sliderPath.selectorSliderX:setPos((-selectedColour.y*95),0,0)
	sliderPath.selectorSliderY:setPos(0,(selectedColour.z*218-218),0)
end

function events.chat_send_message(message)
	if not colourPicker.colourSelectionData then return message end
	host:setChatColor(1,1,1)
	local value = tonumber(host:getChatText())
	if type(value) == "number" then
		if colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].type == 'rgb' then
			local rgb = vectors.hsvToRGB(selectedColour)
			rgb[colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].axis] = math.clamp(tonumber(host:getChatText()),0,colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].max)/colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].max
			selectedColour = vectors.rgbToHSV(rgb)
			colourPicker.updateColours()
		else
			selectedColour[colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].axis] = math.clamp(tonumber(host:getChatText()),0,colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].max)/colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].max
			colourPicker.updateColours()
		end
	elseif colourPicker.colorFeildMetadata[colourPicker.colourSelectionData].type == 'hex' then
		selectedColour = vectors.rgbToHSV(vectors.hexToRGB(host:getChatText())) 
		colourPicker.updateColours() 
	else
		notification:setText('Please enter a number.')
		animations['colourPicker.GUI'].notification:play() 
	end
	host:appendChatHistory(message)
	colourPicker.colourSelectionData = nil
	sounds:playSound("block.stone_button.click_on",player:getPos())
	return
end

function colourPicker.updateColourField(field,value)
	if not host:isChatOpen() then
		notification:setText('Please open chat!\n"Chat Messages" must be enabled in figura settings.')
		animations['colourPicker.GUI'].notification:play()
		return
	end
	colourPicker.colourSelectionData = field
	host:setChatText(value)
	host:setChatColor(0.651,0.447,0.937)
end