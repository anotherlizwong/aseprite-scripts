local spr = app.activeSprite
if not spr then
    return app.alert("No active sprite found.")
end

local mapping = {
    {17, 11, 5},      -- Blue, Green, Orange (body)
    {18, 10, 6},      -- Light Blue, Light Green, Light Orange (body highlight)
    {8, 21, 19},      -- Yellow, White, Sky Blue (eyes)
    {31, 22, 17},     -- Gold, Light Grey, Blue (eye shading)
    {20, 5, 27},      -- Peach, White, Peach (tusk highlight)
    {7, 21, 7},       -- Peach, White, Peach (tusk shading)
    {15, 5, 14},      -- Dark Blue, Orange, Dark Green (clothing)
    {26, 17, 11},     -- Light Purple, Blue, Light Green (clothing 2)
    {2, 15, 14}       -- Dark Purple, Dark Blue, Dark Green (clothing 2 shading)
}

local copyTileToNewLayer=function(name)
    spr.selection:selectAll()
    app.command.Copy()
    app.command.NewLayer{fromClipboard=true}
    app.activeLayer.name = name
    spr.selection:deselect()
end

app.transaction(
    function()
        local variantNames = {"Good", "Neutral", "Evil"}
        app.activeLayer = spr.layers[1]
        app.activeLayer.name = variantNames[1]

        for i = 1, #variantNames-1 do
            app.command.GotoPreviousLayer()
            print("layer to copy: " .. app.activeLayer.name)
            copyTileToNewLayer(variantNames[i + 1])
            print("current layer: " .. app.activeLayer.name)
            -- app.activeLayer = spr.layers[i+1]
            -- spr.selection:selectAll()
            for j, color in ipairs(mapping) do
                -- flip the colors in the palettes
                app.command.ReplaceColor{
                    ui=false, 
                    from=color[1], 
                    to=color[i + 1], 
                    tolerance=0
                }
                print("Replaced color " .. color[1] .. " with " .. color[i + 1])
            end
            spr.selection:deselect()
        end
        app.refresh()
    end
)