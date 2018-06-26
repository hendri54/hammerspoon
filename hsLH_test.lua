local this = {}
hsLH_test = this

function this.test_all()

end


function this.make_history_into_chooser_tb_test()
   local chooserTb = hsLH.make_history_into_chooser_tb();
   for k, v in pairs(chooserTb) do
      assert(type(v.text) == 'string');
   end
end

return this
