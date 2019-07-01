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
  let result = moracle#CardLookup()

  if type(result) == type([])
    let start_pos = result[0]
    let end_pos = result[1]
    let card_name = result[2]
    let oneline = moracle#Oneline(card_name)
    let linetext = getline('.')
    if start_pos == 0
      let newline = oneline . linetext[end_pos+1:]
    else
      let newline = linetext[:start_pos-1] . oneline . linetext[end_pos+1:]
    endif
    call setline(line('.'), newline)
  endif

endfunction

" Returns location and name of the card at current cursor position
" as [start_pos, end_pos, card_name]
function! moracle#CardLookup()
  let lineno = line('.')
  let linetext = getline('.')
  let column = col('.')
  return py3eval('mtg.identify_card_name(mtgdb,
                \ vim.eval("linetext"),
                \ int(vim.eval("column")))')
endfunction

function! moracle#CardNameAtCursor()
  return moracle#CardLookup()[2]
endfunction

" Echoes the list of printings for the card name at cursor.
function! moracle#EchoCardPrintings()
  let card = moracle#CardNameAtCursor()

  echo string(py3eval('mtgdb[vim.eval("card").lower()]["printings"]'))
endfunction

" call ReplaceCardNameWithOneline for each line in the range
function moracle#CommandCardReplace(start, end)
  let pos = getcurpos()
  let editpos = pos
  for lnum in range(a:start, a:end)
    let editpos[1] = lnum
    call setpos('.', editpos)
    call moracle#ReplaceCardNameWithOneline()
  endfor
  call setpos('.', pos)
endfunction

function moracle#CommandCardDisplay(args)
  if a:args == ""
    let card = moracle#CardNameAtCursor()
  else
    let card = a:args
  endif

  echo moracle#Full(card)
endfunction

" Return a list containing a dict for each matching card in `db`.
" Matching occurs if the value for item `key` in `db`
" contains `string`.
" Searching ignores case.
function! moracle#SearchDB(key, string)
  return py3eval('[card["name"] for id, card in iter(mtgdb.items()) if vim.eval("a:key") in card and card[vim.eval("a:key")].lower().find(vim.eval("a:string").lower()) > -1]')
endfunction
