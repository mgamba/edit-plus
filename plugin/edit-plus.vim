" Edit Plus
" Open files with filename:line syntax

" Define EP command
command -nargs=1 -complete=file EP call EditPlus("<args>")

" Override built-in e command with EP when on the vim command line
:cabbrev e <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'EP' : 'e')<CR>

" if there's a line number, call edit with +<line> file syntax
function EditPlus(file_name)
  if ThereIsALineNumber(a:file_name)
    exec 'e +'.LineNumber(a:file_name).' '.FilePath(a:file_name)
  else
    exec 'e '.a:file_name
  endif
endfunction

function ThereIsALineNumber(file_name)
  return strlen(LineNumber(a:file_name))
endfunction

function LineNumber(file_name)
  return strpart(matchstr(a:file_name, ":[0-9]*$"), 1)
endfunction

function FilePath(file_name)
  return substitute(a:file_name, ":[0-9]*$",'','')
endfunction
