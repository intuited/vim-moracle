" vi:filetype=unix:ft=vim

command! -range CardReplace normal gvc=MTGOneline(@-)

command! -range CardFull normal gvy:echo MTGFull(@0)

""!! temp
python3 import sys
python3 sys.path.append('/Users/sixty/src')

" this should all get moved into ../autoload so it doesn't slow down vim startup
python3 import moracle as mtg

python3 mtgdb = mtg.load_db()

function! MTGOneline(cardname)
  let @a = a:cardname
  return py3eval('mtg.format_oneline(mtgdb[vim.eval("@a").lower()], 400)')
endfunction

function! MTGFull(cardname)
  return py3eval('mtg.format_full(mtgdb[vim.eval("a:cardname").lower()])')
endfunction
