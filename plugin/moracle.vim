" vi:fileformat=unix:ft=vim

command! -range CardReplace call moracle#CommandCardReplace("<line1>", "<line2>")
command! -range CardFull normal gvy:echo moracle#Full(@0)
command! -nargs=? -complete=customlist,moracle#CompleteStart CardDisplay
  \ call moracle#CommandCardDisplay("<args>")
command! CardPrintings call moracle#EchoCardPrintings()

command! CardCompleteNames set completefunc=moracle#AutoCompleteName
command! CardCompleteOneline set completefunc=moracle#AutoCompleteOneline
