if did_filetype()
    finish
endif

if getline(1) =~# '^#!.*/bin/env.*\<rust-script\>'
    setfiletype rust
endif
