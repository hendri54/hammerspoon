-- Tag files
local this = {}
tagsLH = this

require('stringLH')


-- Show a dialog where user can enter tags to add to given list of files
function this.tag_dialog(fileList)
   local button, tagList =
      hs.dialog.textPrompt('Add tags',  'Enter tags to add',  '',  'OK',  'Cancel');
   if button ~= 'OK'  or  not tagList then
      return
   end
   local tagTb = stringLH.split(tagList, ',');
   stringLH.trim_table(tagTb);
   this.tag_files(fileList, tagTb);
end


-- Tag a set of files with a set of tags
-- needs testing +++
function this.tag_files(fileList, tagTb)
   for k, v in pairs(fileList) do
      hs.fs.tagsAdd(v, tagTb);
   end
end

return this
