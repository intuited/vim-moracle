python3 import moracle as mtg

echo "moracle: loading MTG db..."
python3 mtgdb = mtg.load_db()

"" add maxwidth arg
function! moracle#oneline(cardname)
  return py3eval('mtg.format_oneline(mtgdb[vim.eval("a:cardname").lower()])')
endfunction

"" add maxwidth arg
function! moracle#full(cardname)
  return py3eval('mtg.format_full(mtgdb[vim.eval("a:cardname").lower()])')
endfunction
