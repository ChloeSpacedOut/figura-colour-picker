# Figura Colour Picker
A colour picker addon, that when added to your avatar, allows you to easily select a colour from a GUI. This includes support for typing, copying, and pasting HEX codes, for even easier colour customisation. The colour picker should work at all GUI scales and resolutions, and only takes around 5kb of space.

## How to use
Add the `colourPicker` folder to your avatar.
Inside your script, to toggle the colour picker, run the following in your script:
```lua
colourPicker.toggle(toggleValue)
```
After a colour is chosen, the `onSubmit()` function will run, which provide the colour as an RGB vec3. By default, this function is already created on init in `colourPicker/core.lua`. Add code that will incorporate the colour inside this function. 
```lua
function colourPicker.onSubmit(colour)
-- your code here
end
```
To use the HEX code editing, ensure you use "Chat Messages" must be turned on in Figura's settings. Please only use this setting at your own risk.
