" vi:filetype=unix:ft=vim

command! -range CardReplace normal gvc=moracle#Oneline(@-)
command! -range CardFull normal gvy:echo moracle#Full(@0)
command! -nargs=1 -complete=customlist,moracle#CompleteStart CardDisplay
  \ echo moracle#Full("<args>")
