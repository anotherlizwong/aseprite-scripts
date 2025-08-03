local spr = app.activeSprite
if not spr then
    return app.alert("No active sprite found.")
end

local mapping = {
    {15, 5, 14},    -- Dark Blue, Orange, Dark Green
    {20, 5, 27},     -- Light Light Blue, Orange, Red
    {17, 11, 5},    -- Blue, Green, Orange
    {8, 21, 3},     -- Yellow, White, Brown
    {18, 10, 6},     -- Light Blue, Light Green, Light Orange
    {2, 15, 14},     -- Dark Purple, Dark Blue, Dark Green
    {31, 22, 3},     -- Gold, Light Grey, Brown
    {26, 17, 11}     -- Light Purple, Blue, Light Green
}

local copyTileToNewLayer=function(name)
    spr.selection:selectAll()
    app.command.CopyMerged()
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