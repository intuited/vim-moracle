python3 import moracle as mtg

echo "moracle: loading MTG db..."
python3 mtgdb = mtg.load_db()

function! moracle#Oneline(cardname, ...)
  let width = a:0 ? a:1 : 0

  return py3eval('mtg.format_oneline(mtgdb[vim.eval("a:cardname").lower()],
                                   \ int(vim.eval("width")))')
endfunction

function! moracle#Full(cardname, ...)
  let width = a:0 ? a:1 : 0
  return py3eval('mtg.format_full(mtgdb[vim.eval("a:cardname").lower()],
                                \ int(vim.eval("width")))')
endfunction

" Return valid card completions as a list.
function! moracle#CompleteStart(ArgLead, CmdLine, CursorPos)
  echo "ArgLead: " . a:ArgLead
  let result =  py3eval('[v["name"] for v in
                 \ mtg.lookup_start(mtgdb,
                                  \ vim.eval("a:ArgLead")).values()]')
  echo "result: " . string(result)
  return result
endfunction
