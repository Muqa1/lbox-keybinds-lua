local box1_color = {25, 25, 25, 255} -- the box above the coloured line
local coloured_line = {255, 132, 0, 255} -- the coloured line
local keyboard_logo_color = {255, 255, 255, 255} -- the keyboard logo colour 
local keybinds_color = {255, 255, 255, 255} -- the "keybinds" text colour that is next to the keyboard logo
local keybind_state_colours = {255, 255, 255, 255} -- the keybind state colour like for an example "doubletap: 100%"


-- no need to edit this stuff down here

REealFont = draw.CreateFont( "Tahoma", 14, 800 )
IconFont = draw.CreateFont( "untitled-font-1", 24, 400 )

menu_x = 200
menu_y = 200

local function waujmujmw()
if engine.IsGameUIVisible() == false then

    local mX = input.GetMousePos()[1] -- mouse x position
    local mY = input.GetMousePos()[2] -- mouse y position
    local boxWidth, boxHeight = 200, 75 -- size of the box

    draw.SetFont( REealFont ) -- set the font to get the text size

    local statuses = {}

--============================--
-- all of the statuses start from here

    if warp.GetChargedTicks() ~= 0 then -- doubletap

        local porcent = math.floor((warp.GetChargedTicks() / 23) * 100)
        table.insert(statuses, "Doubletap: ".. porcent .. "%")

    end

    if (gui.GetValue( "Crit Hack" ) == "force key") or (gui.GetValue( "melee Crit Hack" ) == "force key") then -- crit hack
        if input.IsButtonDown( gui.GetValue( "Crit Hack key" ) ) then
            table.insert(statuses, "Crithack: Held")
        end
    end

    if gui.GetValue( "Aim key" ) ~= 0 then -- aimbot

        aimbot_key = gui.GetValue( "Aim key" )
        aimbot_mode = gui.GetValue( "Aim key mode" )

        if (gui.GetValue( "Aim bot" ) == 1) and (input.IsButtonDown( aimbot_key )) and (aimbot_mode == "hold-to-use") then 
            table.insert(statuses, "Aimbot key: Held" )
        end

        if (gui.GetValue( "Aim bot" ) == 1) and (aimbot_mode == "press-to-toggle") then
            table.insert(statuses, "Aimbot key: Toggeled" )
        end

    end

    if gui.GetValue( "Trigger shoot" ) == 1 then -- trigger shoot
        if input.IsButtonDown( gui.GetValue( "Trigger shoot key" ) ) then
            table.insert(statuses, "Trigger shoot: Held" )
        end
    end

    if gui.GetValue( "Trigger key" ) ~= 0 then -- trigger key
        if input.IsButtonDown( gui.GetValue( "Trigger key" ) ) then
            table.insert(statuses, "Trigger key: Held" )
        end
    end

    if gui.GetValue( "Fake Lag" ) ~= 0 then -- fakelag

        local fakelag_ticks = (gui.GetValue( "Fake lag value (ms)" ) + 15) /15
        fakelag_ticks = math.floor(fakelag_ticks)
        table.insert(statuses, "Fake lag: ".. fakelag_ticks.. " ticks")

    end

    if gui.GetValue( "Anti Aim" ) ~= 0 then -- anti aim
        table.insert(statuses, "Anti aim: On")
    end

    if gui.GetValue( "Fake Latency" ) == 1 then -- fake latency
        table.insert(statuses, "Fake latency: ".. (gui.GetValue( "Fake latency value (ms)" ) / 1000).. " seconds")
    end

    if gui.GetValue( "Thirdperson" ) ~= 0 then -- thirdperson
        if gui.GetValue( "thirdperson key" ) ~= 0 then
            table.insert(statuses, "Thirdperson: Toggled")
        else 
            table.insert(statuses, "Thirdperson: On")
        end
    end

-- all of the statuses end here
--============================--
    local startY = 20
    local textHeight = 0 -- calculate the total height of the text
    for i, status in ipairs(statuses) do
        draw.Color( table.unpack(keybind_state_colours) )
        local width, height = draw.GetTextSize(status)
        draw.Text(math.floor(menu_x + 2), math.floor(menu_y + startY), status)
        startY = startY + 15
        textHeight = textHeight + (height + 1)
    end

    boxHeight = 20 + textHeight -- update the box height

    if input.IsButtonDown(MOUSE_LEFT) and -- is the cursor inside the box?
       mX >= menu_x and mX <= menu_x + boxWidth and
       mY >= menu_y and mY <= menu_y + boxHeight then
        menu_x = mX - boxWidth/2
        menu_y = mY - boxHeight/2
    end

    --draw.Color(50, 50, 50, 150) -- drawing the main box  -- currently disabled because it is drawing on top of the text
    --draw.FilledRect(math.floor(menu_x), math.floor(menu_y), math.floor(menu_x + boxWidth), math.floor(menu_y + boxHeight))

    draw.Color( table.unpack(box1_color) ) -- drawing the darker box above the main box
    draw.FilledRect(math.floor(menu_x), math.floor(menu_y), math.floor(menu_x + boxWidth), math.floor(menu_y + 20))  

    draw.Color( table.unpack(coloured_line) ) -- drawing the coloured line
    draw.FilledRect(math.floor(menu_x), math.floor(menu_y) + 18, math.floor(menu_x + boxWidth), math.floor(menu_y + 20))

    draw.SetFont( IconFont ) -- drawing the keyboard logo
    draw.Color( table.unpack(keyboard_logo_color) )
    draw.Text(math.floor(menu_x) + 2, math.floor(menu_y) - 2,  "a" )
    
    draw.SetFont( REealFont ) -- drawing the keybinds text
    draw.Color(table.unpack(keybinds_color))
    draw.Text(math.floor(menu_x) + 30, math.floor(menu_y) + 2, "keybinds")

end
end

callbacks.Register("Draw", "waujmujmw", waujmujmw)
print(gui.GetValue( "Melee crit hack" ))
