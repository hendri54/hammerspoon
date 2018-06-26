local this = {}
oneKeyChooserLH_test = this

function this.test_all()
   this.show_line_test()
end


function this.show_line_test()
   local inputTb = {"A",  "text for A", "more for A"}
   local showLine = oneKeyChooserLH.make_line_to_show(inputTb)
   -- print(showLine)
   assert(showLine == "A\t\ttext for A\t\tmore for A")
end


----------  Interactive tests

function this.choose_from_list_test()
   inputTb = {{"S", "Save file"},  {"O", "Open file"}}
   oneKeyChooserLH.choose_from_list(inputTb)
end

function this.show_list_test()
   inputTb = {{"S", "Save file"},  {"O", "Open file"}}
   x = oneKeyChooserLH.show_list(inputTb, 5)
end



return this
