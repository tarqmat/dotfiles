if exists('b:did_ftplugin_mygo')
  finish
endif
let b:did_ftplugin_mygo = 1

setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal shiftround
setlocal completeopt=menu
compiler go
