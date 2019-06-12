function! MTGOneline(cardname)
  let @a = a:cardname
  return py3eval('mtg.format_oneline(db[vim.eval("@a").lower()], 400)')
endfunction
