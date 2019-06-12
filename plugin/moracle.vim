" vi:filetype=unix:ft=vim

command! -range CardReplace normal gvc=moracle#oneline(@-)
command! -range CardFull normal gvy:echo moracle#full(@0)
