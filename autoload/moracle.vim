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
  let result =  py3eval('[v["name"] for v in
                 \ mtg.lookup_start(mtgdb,
                                  \ vim.eval("a:ArgLead")).values()]')
  return result
endfunction

function! moracle#ReplaceCardNameWithOneline()
  let lineno = line('.')
  let linetext = getline('.')
  let column = col('.')
  let result = py3eval('mtg.identify_card_name(mtgdb,
                      \ vim.eval("linetext"),
                      \ int(vim.eval("column")))')
  if type(result) == type([])
    let start_pos = result[0]
    let end_pos = result[1]
    let card_name = result[2]
    let oneline = moracle#Oneline(card_name)
    if start_pos == 0
      let newline = oneline . linetext[end_pos+1:]
    else
      let newline = linetext[:start_pos-1] . oneline . linetext[end_pos+1:]
    endif
    call setline(lineno, newline)
  endif

endfunction

" Returns the name of the card at the current cursor position
function! moracle#CardNameAtCursor()
  let lineno = line('.')
  let linetext = getline('.')
  let column = col('.')
  return py3eval('mtg.identify_card_name(mtgdb,
                \ vim.eval("linetext"),
                \ int(vim.eval("column")))')
endfunction

" Echoes the list of printings for the card name at cursor.
function! moracle#EchoCardPrintings()
  result = moracle#CardNameAtCursor()

  if type(result) == type([])
    let card = result[2]
    echo string(py3eval('mtgdb[vim.eval("card").lower()]["printings"]'))
  endif
endfunction

" Return a list containing a dict for each matching card in `db`.
" Matching occurs if the value for item `key` in `db`
" contains `string`.
" Searching ignores case.
function! moracle#SearchDB(key, string)
  return py3eval('[card["name"] for id, card in iter(mtgdb.items()) if vim.eval("a:key") in card and card[vim.eval("a:key")].lower().find(vim.eval("a:string").lower()) > -1]')
endfunction
