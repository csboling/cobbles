-- circle doodler + tile effect
-- K1: alt
-- K2: clear buffer
-- K3: tile capture region
-- E1: radius
--   alt: capture size
-- E2: x pos
--   alt: capture x pos
-- E3: y pos
--   alt: capture y pos 

x = 0
y = 0
r = 15

xcap = 0
ycap = 0
dim = 24
copy = false

function enc(n, d)
  if n == 1 then
    if held_keys[1] then
      dim = util.clamp(dim + d, 4, 64)
      print('dim ' .. dim)
    else
      r = util.clamp(r + d, 1, 128)
    end
  elseif n == 2 then
    if held_keys[1] then
      xcap = util.clamp(xcap + d, 0, 128 - dim)
      print('xcap ' .. xcap)
    else
      x = util.clamp(x + d, 0, 127)
    end
  elseif n == 3 then
    if held_keys[1] then
      ycap = util.clamp(ycap + d, 0, 64 - dim)
      print('ycap ' .. ycap)
    else
      y = util.clamp(y + d, 0, 63)
    end
  end
  redraw()
end

held_keys = {false, false, false}
function key(n, z)
  held_keys[n] = z == 1
  if z == 1 then
    if n == 2 then
      screen.clear()
      redraw()
    elseif n == 3 then
      s = screen.peek(xcap, ycap, dim, dim)
      copy = true
      redraw()
    end
  end
end

function init()
  print('ok')
end

function redraw()
  if copy then
    copy = false
    local w = math.ceil(128 / dim)
    local h = math.ceil(64 / dim) 
    for i=1,w do
      for j=1,h do
        screen.poke((i - 1) * dim, (j - 1) * dim, dim, dim, s)
      end
    end
  else
    screen.level(math.random(0, 15))
    screen.move(x, y)
    screen.circle(x, y, 2 * r)
    screen.stroke()
  end
  screen.update()
end