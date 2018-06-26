local this = {}
stringLH_test = this

packageLH.reload('stringLH')

function this.test_all()
   this.split_test()
   this.trim_test()
   this.trim_table_test();
end


function this.trim_table_test()
   print('Testing trim_table')
   local tbIn = {'abc', 122, ' def '};
   assert(stringLH.trim_table(tbIn),  {'abc', 122, 'def'})
end


function this.trim_test()
   assert(stringLH.trim('abc def'), 'abc def');
   assert(stringLH.trim(' abc def'), 'abc def');
   assert(stringLH.trim(' abc def '), 'abc def');
end


function this.split_test()
   local s = 'abc, d, efg';
   local t = stringLH.split(s, ',');
   assert(tableLH.equal(t, {[1] = 'abc', [2] = ' d', [3] = ' efg'}))

   s = 'abc def';
   t = stringLH.split(s, ',');
   assert(tableLH.equal(t, {[1] = s}))
end

return this
