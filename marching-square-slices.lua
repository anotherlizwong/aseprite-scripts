local spr = app.activeSprite
if not spr then
    return app.alert("No active sprite found.")
end

local slice_size = 64
local cols = 4

app.transaction(
  function()
    local count = 1
    for i = 0, cols - 1 do
      for j = 0, cols - 1 do     
        local newslice = spr:newSlice(Rectangle(
          j * slice_size, i * slice_size, slice_size, slice_size
        ))
        newslice.name = string.format("%d", count)
        newslice.color = Color{ r=math.random(256)-1,
                                      g=math.random(256)-1,
                                      b=math.random(256)-1 }
        count = count + 1
      end
    end
  end
)

app.refresh()

