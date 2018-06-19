local this = {}
textReplaceLH_test = this

function this.test_all()
   this.app_table_test()
   this.replacement_table_test()
   this.app_specific_replace_test()
   this.generic_replace_test()
   this.replace_test()
   this.choice_table_test()
end


function this.app_table_test()
   local t = textReplaceLH.app_table("bear")
   assert(t)
   assert(t["test1"] == "t1")
end


function this.replacement_table_test()
   local t = textReplaceLH.replacement_table("bear")
   assert(t["test1"] == "t1")
   assert(t["gmail"] == "hendricks.lutz@gmail.com")
end


function this.app_specific_replace_test()
   local str1 = textReplaceLH.app_specific_replace_text("test1", "bear")
   assert(str1 == "t1")

   local str2 = textReplaceLH.app_specific_replace_text("test1", nil)
   assert(not str2)
end

function this.generic_replace_test()
   local str1 = textReplaceLH.generic_replace_text("gmail")
   assert(str1 == constLH.constant("gmail"))
end

function this.replace_test()
   local appName = "bear"
   local typeIt = false

   local macroName = "test1"
   local str1 = textReplaceLH.replace_text(macroName, appName, typeIt)
   local str2 = textReplaceLH.app_specific_replace_text(macroName, appName)
   assert(str1 == str2)

   macroName = "gmail"
   str1 = textReplaceLH.replace_text(macroName, appName, typeIt)
   str2 = textReplaceLH.generic_replace_text(macroName, appName)
   assert(str1 == str2)
end

function this.choice_table_test()
   local appName = "bear"
   local choiceTb = textReplaceLH.choice_table(appName)

   local foundGeneric = false
   local foundAppSpecific = false
   for k, v in pairs(choiceTb) do
      if v.text == "gmail" then
         foundGeneric = true
      end
      if v.text == "test1" then
         foundAppSpecific = true
      end
   end

   assert(foundGeneric)
   assert(foundAppSpecific)
end

return this
