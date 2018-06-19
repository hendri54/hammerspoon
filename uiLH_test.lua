this = {}
uiLH_test = this

function this.test_all()
   this.table_for_chooser_test()
   this.show_line_test()
   this.replacement_table_test()
end


function this.choose_from_list_test()
   inputTb = {{"S", "Save file"},  {"O", "Open file"}}
   uiLH.choose_from_list(inputTb)
end

function this.show_list_test()
   inputTb = {{"S", "Save file"},  {"O", "Open file"}}
   x = uiLH.show_list(inputTb, 5)
end

function this.show_line_test()
   local inputTb = {"A",  "text for A", "more for A"}
   local showLine = uiLH.make_line_to_show(inputTb)
   -- print(showLine)
   assert(showLine == "A\t\ttext for A\t\tmore for A")
end

function this.replacement_table_test()
   local t = uiLH.replacement_table()
   assert(t.Test)
end


function this.table_for_chooser_test()
   local tbIn = {t1 = "abc",  t2 = 123}
   local tbOut = uiLH.table_for_chooser(tbIn)
   local found = false
   for k,v in pairs(tbOut) do
      if v.text == "t2" then
         found = true
      end
   end
   assert(found)
end


function this.generic_chooser_test()
   -- uiLH.genericChooserChoice = nil
   local choiceTb = {{["text"] = "Office startup"},
		{["text"] = "Home startup"},  {["text"] = "Test"}}
   uiLH.generic_chooser(this.choice_fct_test, choiceTb)
end

function this.choice_fct_test(choice)
   print("Callback function")
   if choice then
      print(choice.text)
   else
      print("Nothing chosen")
   end
end

return this
