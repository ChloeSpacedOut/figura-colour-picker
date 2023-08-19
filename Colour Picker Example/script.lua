require('colourPicker.core')

pings.setColor = function (color)
    models.model.cube:setColor(color)
end

if not host:isHost() then return end
colourPicker.toggle(false)

examplePage = action_wheel:newPage()
action_wheel:setPage(examplePage)
testAction = examplePage:newAction(1):setTitle('Colour Picker')

function testAction.leftClick()
    colourPicker.toggle(true)
end

function colourPicker.onSubmit(colour)
    pings['setColor'](colour)
end