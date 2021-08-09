" vi:fileformat=unix:ft=vim

command! -range CardReplace call moracle#CommandCardReplace("<line1>", "<line2>")
command! -range CardFull normal gvy:echo moracle#Full(@0)
command! -nargs=? -complete=customlist,moracle#CompleteStart CardDisplay
  \ call moracle#CommandCardDisplay("<args>")
command! CardPrintings call moracle#EchoCardPrintings()

command! CardCompleteNames set completefunc=moracle#AutoCompleteName
command! CardCompleteOneline set completefunc=moracle#AutoCompleteOneline

" TODO: figure out how to make this not clobber the namespace
command! -range -nargs=1 Py3Filter call moracle#FilterLinesThroughPython3("<args>", "<line1>", "<line2>")

command! -range -nargs=? CardSort call moracle#CommandCardSort("<args>", "<line1>", "<line2>")

command! -range -nargs=? CardPricing call moracle#AppendPricing("<args>", "<line1>", "<line2>")
