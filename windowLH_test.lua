local this = {}
windowLH_test = this

function this.test_all()
   this.screen_right_edge_test()
   this.fit_win_to_screen_width_test()
   this.change_width_left_test()
   -- this.window_size_change_test()
end

function this.screen_right_edge_test()
   local screenDims = screen_dims()
   rightEdge = windowLH.screen_right_edge(screenDims)
   assert(rightEdge > 1600)
end

function this.fit_win_to_screen_width_test()
   local screenDims = screen_dims()
   local x = screenDims.x + 10
   local w = screenDims.w + 50
   xOut, wOut = windowLH.fit_win_to_screen_width(x, w, screenDims)
   assert(xOut == screenDims.x)
   assert(wOut == screenDims.w)

   w = screenDims.w - 100
   xOut, wOut = windowLH.fit_win_to_screen_width(x, w, screenDims)
   assert(xOut == x)
   assert(wOut == w)
end

function this.change_width_left_test()
   x = 800
   w = 400
   screenDims = screen_dims()
   changePct = 10
   xOut, wOut =
      windowLH.change_width_left(x, w, screenDims, changePct);
   local newWidth = round(w * (1 + changePct / 100))
   local wChange = newWidth - w
   assert(xOut == x - wChange)
   assert(wOut == newWidth)
end

function this.window_size_change_test()
   windowLH.window_size_change(nil, "right", 10)
end

function round(x)
   return math.floor(x + 0.5)
end

function screen_dims()
   -- function: current screen dims
   local win = hs.window.focusedWindow()
   local currScreen = win:screen()
   local screenDims = currScreen:frame()
   return screenDims
end

return this
