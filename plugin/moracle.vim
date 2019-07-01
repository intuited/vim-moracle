" vi:fileformat=unix:ft=vim

command! CardReplace call moracle#ReplaceCardNameWithOneline()
command! -range CardVisualReplace normal gvc=moracle#Oneline(@-)
command! -range CardFull normal gvy:echo moracle#Full(@0)
command! -nargs=1 -complete=customlist,moracle#CompleteStart CardDisplay
  \ echo moracle#Full("<args>")
command! CardPrintings call moracle#EchoCardPrintings()
