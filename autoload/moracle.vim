python3 import moracle as mtg

echo "moracle: loading MTG db..."
python3 mtgdb = mtg.load_db()

function! moracle#oneline(cardname, ...)
  let width = a:0 ? a:1 : 0

  return py3eval('mtg.format_oneline(mtgdb[vim.eval("a:cardname").lower()],
                                   \ int(vim.eval("width")))')
endfunction

function! moracle#full(cardname, ...)
  let width = a:0 ? a:1 : 0
  return py3eval('mtg.format_full(mtgdb[vim.eval("a:cardname").lower()],
                                \ int(vim.eval("width")))')
endfunction
